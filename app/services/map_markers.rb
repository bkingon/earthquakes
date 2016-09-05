class MapMarkers
  def initialize(earthquakes)
    @earthquakes = earthquakes
  end

  def call
    earthquakes.map do |quake|
      marker_attr = MapMarkerAttributes.new(quake)
      next if marker_attr.latitude.nil? || marker_attr.longitude.nil?
      {
        lat: marker_attr.latitude,
        lng: marker_attr.longitude,
        infowindow: "#{marker_attr.place}</br>Magnitude: #{marker_attr.magnitude}</br>When: #{marker_attr.time}",
        mag: marker_attr.magnitude,
        name: marker_attr.place,
        time: marker_attr.time
      }
    end
  end

  private

  attr_accessor :earthquakes
end
