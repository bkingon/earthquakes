class EarthquakeQuery
  def initialize(query_params)
    @query_params = query_params
  end

  def call
    connection = EarthquakeApi.new.call
    response = connection.get '/fdsnws/event/1/query', query_params

    if response.body.first(1000).include?('exceeds search limit')
      query_params.delete(:filtered_params)
      response = connection.get '/fdsnws/event/1/query', query_params
      @error_message = 'Search parameters exceed 20,000 results. Please modify your search parameters.'
    end

    JSON.parse(response.body)['features']
  end

  private

  attr_accessor :query_params
end
