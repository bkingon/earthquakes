class DashboardController < ApplicationController
  def index
    response = EarthquakeQuery.new(filter_params).call
    json_earthquakes = evaluate_response(response)

    @filtered_params = {starttime: start_time.to_date.strftime("%Y-%m-%d"), endtime: end_time.to_date.strftime("%Y-%m-%d"), minmagnitude: min_magnitude}
    @hash = MapMarkers.new(json_earthquakes).call
    flash[:alert] = @error_message if @error_message
  end

  private
  def evaluate_response(response)
    if response.status != 200
      if response.body.first(1000).include?('exceeds search limit')
        @error_message = 'Search parameters exceed 20,000 results. Please modify your search parameters.'
      else
        @error_message = 'Something went wrong with your search, please try again.'
      end

      params.delete(:filtered_params)
      response = EarthquakeQuery.new(filter_params).call
    end

    JSON.parse(response.body)['features']
  end

  def filter_params
    {format: 'geojson', starttime: start_time, endtime: end_time, minmagnitude: min_magnitude}
  end

  def start_time
    params['filtered_params'].present? ? params['filtered_params']['starttime'] : Date.yesterday.to_s
  end

  def end_time
    params['filtered_params'].present? ? params['filtered_params']['endtime'] : Date.today.to_s
  end

  def min_magnitude
    params['filtered_params'].present? ? sanitize_number(params['filtered_params']['minmagnitude']) : 0
  end

  def sanitize_number(string)
    string.to_i if Float(string) rescue 0
  end
end
