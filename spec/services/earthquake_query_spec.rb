require 'rails_helper'

describe EarthquakeQuery do
  it 'gets the last days results' do
    VCR.use_cassette('single_day_query') do
      params = DashboardIndexParams.parse({ filtered_params: { endtime: '2016-09-05', minmagnitude: 4, starttime: '2016-09-04' }}.deep_stringify_keys)
      response = EarthquakeQuery.new(params).call
      expect(response.status).to eq 200
      expect(JSON.parse(response.body)['features'].count).to eq 17
    end
  end
end
