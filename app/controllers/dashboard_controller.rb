class DashboardController < ApplicationController
  def index
    connection = EarthquakeApi.new.call
    # response = connection.get '1/query?format=geojson&starttime=2016-09-01&endtime=2016-9-02'
    starttime = params['starttime'].present? ? params['starttime']['starttime'] : Date.yesterday.to_s
    endtime = params['endtime'].present? ? params['endtime']['endtime'] : Date.today.to_s
    minmagnitude = params['minmagnitude'].present? ? params['minmagnitude'].to_i : 4
    qu_params = {format: 'geojson', starttime: starttime, endtime: endtime, minmagnitude: minmagnitude}
    # params['starttime'] = starttime
    # params['endtime'] = endtime
    # response = connection.get do |req|
    #   query_parmas.each do |key, value|
    #     req.params[key] = value
    #   end
    # end
    response = connection.get '/fdsnws/event/1/query', qu_params
    if response.body.first(1000).include?('exceeds search limit')
      starttime = Date.yesterday.to_s
      endtime = Date.today.to_s
      qu_params = {format: 'geojson', starttime: starttime, endtime: endtime, minmagnitude: 4}
      response = connection.get '/fdsnws/event/1/query', qu_params
      json_response = JSON.parse(response.body)['features']
      @earthquakes = json_response.select { |e| e['properties']['mag'] > 3 }

      @error_message = 'Search parameters exceed 20,000 results. Please modify your search parameters.'
      render :index
    else
      json_response = JSON.parse(response.body)['features']
      @earthquakes = json_response.select { |e| e['properties']['mag'] > 3 }
      @hash = []
      @earthquakes.each do |quake|
        next if quake['geometry']['coordinates'][0].nil? || quake['geometry']['coordinates'][1].nil?
        hash = {}
        hash[:lat] = quake['geometry']['coordinates'][1]
        hash[:lng] = quake['geometry']['coordinates'][0]
        hash[:infowindow] = quake['properties']['mag'].to_s
        hash[:mag] = quake['properties']['mag'].to_s
        hash[:name] = quake['properties']['place']
        hash[:time] = Time.at(quake['properties']['time'] / 1000).to_datetime
        @hash << hash
      end
      # @hash = Gmaps4rails.build_markers(@earthquakes) do |quake, marker|
        # next if quake['geometry']['coordinates'][0].nil? || quake['geometry']['coordinates'][1].nil?
        # hash = {}
        # hash[:lat] = quake['geometry']['coordinates'][1]
        # hash[:lng] = quake['geometry']['coordinates'][0]
        # hash[:infowindow] = quake['properties']['mag'].to_s
        # marker.lat quake['geometry']['coordinates'][1]
        # marker.lng quake['geometry']['coordinates'][0]
        # marker.infowindow quake['properties']['mag'].to_s
        # hash
      # end
    end
  end

  private

  # def filter_params
  #   f_params = params.slice(
  #     :starttime,
  #     :endtime
  #   )
  #
  #   f_params.blank? ? nil : f_params
  # end
end
