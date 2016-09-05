class MapMarkerAttributes
  def initialize(earthquake)
    @earthquake = earthquake
  end

  def time
    Time.at(earthquake['properties']['time'] / 1000).to_datetime.strftime('%B %d, %Y - %I:%M%p')
  end

  def latitude
    earthquake['geometry']['coordinates'][1]
  end

  def longitude
    earthquake['geometry']['coordinates'][0]
  end

  def magnitude
    earthquake['properties']['mag'].to_s
  end

  def place
    earthquake['properties']['place']
  end

  private

  attr_accessor :earthquake
end
