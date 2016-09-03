class DashboardController < ApplicationController
  def index
    connection = EarthquakeApi.new.call
    # response = connection.get '1/query?format=geojson&starttime=2016-09-01&endtime=2016-9-02'
    query_params = {format: 'geojson', :starttime => '2016-09-01', :endtime => '2016-09-02'}
    # response = connection.get do |req|
    #   query_parmas.each do |key, value|
    #     req.params[key] = value
    #   end
    # end
    response = connection.get '/fdsnws/event/1/query', query_params
    json_response = JSON.parse(response.body)['features']
    @earthquakes = json_response.select { |e| e['properties']['mag'] > 3 }
  end
end
