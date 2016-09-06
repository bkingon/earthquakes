# Earthquakes

Have you ever wondered where the nearest seismic activity was?
Well, this app allows the user to query the USGS Earthquakes database. The results are then placed into a Google Maps view, and markers are placed to identify the locations of where earthquakes have taken place.

![Earthquake](https://media.giphy.com/media/3o85xoKJdWyZ35P6OQ/giphy.gif)

Demo App: https://earthquakes-history.herokuapp.com

### Details:
* Ruby version: 2.3.1
* Rails version: 5.0.0.1
* Database: None

### Installation
* Clone the app: `git clone git@github.com:bkingon/earthquakes.git`
* `bundle install`
* Add a Google Maps API key to your .env file: `GOOGLE_MAPS_API_KEY=[YOUR API KEY]`
  * Get a Google Maps API key [here](https://developers.google.com/maps/documentation/javascript/reference)
* Run the server: `rails s`
