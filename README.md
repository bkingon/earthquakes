# Earthquakes

This app allows the user to query the USGS Earthquakes database. The results are then placed into  Google Maps view, and markers are placed to identify the locations of where earthquakes have taken place.

Demo App: https://earthquakes-history.herokuapp.com

### Details:
* Ruby version: 2.3.1
* Rails version: 5.0.0.1
* Database: None

### Installation
* Clone the app: `git clone git@github.com:bkingon/earthquakes.git`
* `bundle install`
* Add a Google Maps API key to your .env file: `GOOGLE_MAPS_API_KEY=[YOU API KEY]`
  * Get Google Maps API key [here](https://developers.google.com/maps/documentation/javascript/reference)
* Run the server: `rails s`
