require 'rails_helper'

describe EarthquakeQuery do
  it 'gets the last days results' do
    VCR.use_cassette('single_day_query') do
      parsed_json = EarthquakeQuery.new({ format: 'geojson', starttime: '2016-09-04', endtime: '2016-09-05', minmagnitude: 4 }).call
      expect(parsed_json.count).to eq 16
    end
  end
end

        # parsed_json = EarthquakeQuery.new({ starttime: '2016-01-01', endtime: '2016-09-01', minmagnitude: 0 }).call
