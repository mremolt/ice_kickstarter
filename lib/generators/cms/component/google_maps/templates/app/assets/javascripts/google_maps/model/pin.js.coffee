class window.GoogleMap.Model.Pin
  self = null
  body = null
  title = null
  latitude = null
  longitude = null

  constructor: (data)->
    self = this
    self.title = data.title
    self.body = data.body
    self.latitude = data.latitude
    self.longitude = data.longitude

  googleMapMarker: ->
    marker = new google.maps.Marker {
      position: new window.google.maps.LatLng(self.latitude, self.longitude)
      title: self.title
    }

  setMap: (map)->
    marker = self.googleMapMarker()

    infowindow = new google.maps.InfoWindow {
      content: self.content()
    }

    window.google.maps.event.addListener marker, 'click', ->
      infowindow.open(map, marker)

    marker.setMap(map)

  content: ->
    contentString = ''

    if self.title
      contentString += '<h3>' + self.title + '</h3>'

    if self.body
      contentString += '<p>' + self.body + '</p>'

    contentString