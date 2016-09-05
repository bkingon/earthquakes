class MapMarkers
  def initialize(earthquakes)
    @earthquakes = earthquakes
  end

  def call
    earthquakes.map do |quake|
      next if latitude.nil? || longitude.nil?
      {
        lat: latitude,
        lng: longitude,
        infowindow: "#{place}</br>Magnitude: #{mag}</br>When: #{time(quake)}",
        mag: magnitude,
        name: place,
        time: time(quake)
      }
    end
  end

  private

  attr_accessor :earthquakes

  def time(quake)
    Time.at(quake['properties']['time'] / 1000).to_datetime.strftime('%B %d, %Y - %I:%M%p')
  end

  def latitude
    quake['geometry']['coordinates'][1]
  end

  def longitude
    quake['geometry']['coordinates'][0]
  end

  def magnitude
    quake['properties']['mag'].to_s
  end

  def place
    quake['properties']['place']
  end
end
