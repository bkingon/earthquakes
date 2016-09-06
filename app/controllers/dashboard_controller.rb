class DashboardController < ApplicationController
  def index
    earthquake_response = query_earthquake_api(params)
    json_earthquakes = evaluate_response(earthquake_response)

    @map_markers_hash = MapMarkers.new(json_earthquakes).call
    flash[:alert] = @error_message if @error_message
  end

  private
  def evaluate_response(earthquake_response)
    if earthquake_response.status != 200
      add_error_message(earthquake_response)
      earthquake_response = query_earthquake_api({})
    end

    JSON.parse(earthquake_response.body)['features']
  end

  def add_error_message(earthquake_response)
    if earthquake_response.body.first(1000).include?('exceeds search limit')
      @error_message = 'Search parameters exceed 20,000 results. Please modify your search parameters.'
    else
      @error_message = 'Something went wrong with your search, please try again.'
    end
  end

  def query_earthquake_api(query_params)
    @filtered_params = DashboardIndexParams.parse(query_params)
    EarthquakeQuery.new(@filtered_params).call
  end
end
