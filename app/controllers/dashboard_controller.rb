class DashboardController < ApplicationController
  def index
    json_earthquakes = EarthquakeQuery.new(filter_params).call

    @filtered_params = {starttime: start_time.to_date.strftime("%Y-%m-%d"), endtime: end_time.to_date.strftime("%Y-%m-%d"), minmagnitude: min_magnitude}
    @hash = MapMarkers.new(json_earthquakes).call
  end

  private

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
