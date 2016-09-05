class EarthquakeQuery
  def initialize(query_params)
    @query_params = query_params
  end

  def call
    connection = EarthquakeApi.new.call
    connection.get '/fdsnws/event/1/query', query_params
  end

  private

  attr_accessor :query_params
end
