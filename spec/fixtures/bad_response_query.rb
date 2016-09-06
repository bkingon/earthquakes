module Fixtures
  def self.bad_response_query
    OpenStruct.new(
      status: 400,
      body: <<EOS
Error 400: Bad Request

Something went wrong here.

Usage details are available from http://earthquake.usgs.gov/fdsnws/event/1

Request:
/fdsnws/event/1/query?endtime=2016-09-05&format=geojson&minmagnitude=0&starttime=2016-01-04

Request Submitted:
2016-09-06T21:41:47+00:00

Service version:
1.5.2
EOS
    )
  end
end
