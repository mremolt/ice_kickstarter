class window.GoogleMap.Initialize.Initializer
  self = null
  map = null
  pins = null
  urlIdentifier = null
  mainIdentifier = null

  constructor: (@mainIdentifier, @urlIdentifier)->
    self = this

  init: ->
    self.loadMapData()

  loadMapData: ->
    $.ajax $(self.urlIdentifier).text(),
        type: 'GET'
        dataType: 'json'
        success: (data, textStatus, jqXHR) ->
          self.mapDataSuccessfullLoaded(data)

  mapDataSuccessfullLoaded: (data)->
    parser = new window.GoogleMap.Tool.Parser()
    map = parser.parseMap(data)
    map.domIdentifier = self.mainIdentifier
    map.googleMap()