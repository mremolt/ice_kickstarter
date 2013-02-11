class window.GoogleMap.Model.Map
  self = null
  pins = []
  map = null
  mapType = 0
  zoomLevel = 0
  domIdentifier = ''
  centerLatitude = 0
  centerLongitude = 0

  constructor: (config = {})->
    self = this
    self.assignConfig(config)

  assignConfig: (config = {})->
    self.mapType = config.map_type
    self.zoomLevel = config.zoom_level
    self.domIdentifier = config.dom_identifier
    self.centerLatitude = config.center_latitude
    self.centerLongitude = config.center_longitude

    #defaults
    self.mapType ?= 'ROADMAP'
    self.zoomLevel ?= 8
    self.domIdentifier ?= '.map'
    self.centerLatitude ?= 0
    self.centerLongitude ?= 0

  googleMapConfig: ->
    return {
      center: new window.google.maps.LatLng(self.centerLatitude, self.centerLongitude),
      zoom: self.zoomLevel,
      mapTypeId: eval('google.maps.MapTypeId.' + self.mapType)
    }

  googleMap: ->
    map = new window.google.maps.Map(
      $.find(self.domIdentifier)[0],
      self.googleMapConfig()
    )

    self.pins.map (pin)->
      pin.setMap(map)

    map
