class window.GoogleMap.Tool.Parser
  self = null

  constructor: ->
    self = this

  parsePins: (data)->
    pins = new Array()
    pinsData = data[this.pinsIdentifier()]

    for pinData in pinsData
      do (pinData) ->
        pin = new window.GoogleMap.Model.Pin(pinData)
        pins.push(pin)

    return pins

  parseMap: (data)->
    mapData = data[this.mapIdentifier()]

    map = new window.GoogleMap.Model.Map(mapData)
    map.pins = self.parsePins(mapData)

    return map

  mapIdentifier: ->
    'map'

  pinsIdentifier: ->
    'pins'