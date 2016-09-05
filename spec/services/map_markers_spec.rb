require 'rails_helper'

def earthquake_data
  [
    {
      'geometry' => {
        'coordinates' => [123, 456, 78]
      },
      'properties' => {
        'mag' => 5,
        'place' => 'Somewhere out there',
        'time' => 1472945300000
      }
    },
    {
      'geometry' => {
        'coordinates' => [786, 543, 21]
      },
      'properties' => {
        'mag' => 7,
        'place' => 'Nowhere out there',
        'time' => 1472944793560
      }
    }
  ]
end

describe MapMarkers do
  it 'creates the hash of map markers' do
    map_markers = MapMarkers.new(earthquake_data).call
    expect(map_markers.count).to eq 2
  end
end
