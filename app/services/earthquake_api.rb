class EarthquakeApi < SimpleDelegator
  def initialize(client = nil)
    super(client || default_api_client)
  end

  private
  def default_api_client
    Faraday.new(:url => 'http://earthquake.usgs.gov') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end
end
