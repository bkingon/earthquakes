class EarthquakeQuery
  def initialize(query_params)
    @query_params = query_params
  end

  def call
    connection = EarthquakeApi.new
    connection.get '/fdsnws/event/1/query', filter_params
  end

  private
  attr_accessor :query_params

  def filter_params
    {format: 'geojson', starttime: query_params.start_time, endtime: query_params.end_time, minmagnitude: query_params.min_magnitude}
  end
end
