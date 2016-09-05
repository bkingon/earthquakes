class MapMarkers
  def initialize(earthquakes)
    @earthquakes = earthquakes
  end

  def call
    earthquakes.map do |quake|
      next if quake['geometry']['coordinates'][0].nil? || quake['geometry']['coordinates'][1].nil?
      {
        lat: quake['geometry']['coordinates'][1],
        lng: quake['geometry']['coordinates'][0],
        infowindow: quake['properties']['mag'].to_s,
        mag: quake['properties']['mag'].to_s,
        name: quake['properties']['place'],
        time: Time.at(quake['properties']['time'] / 1000).to_datetime
      }
    end
  end

  private

  attr_accessor :earthquakes
end
