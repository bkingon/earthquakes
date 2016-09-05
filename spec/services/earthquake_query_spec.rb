require 'rails_helper'

describe EarthquakeQuery do
  it 'gets the last days results' do
    VCR.use_cassette('single_day_query') do
      response = EarthquakeQuery.new({ format: 'geojson', starttime: '2016-09-04', endtime: '2016-09-05', minmagnitude: 4 }).call
      expect(response.status).to eq 200
      expect(JSON.parse(response.body)['features'].count).to eq 16
    end
  end
end
