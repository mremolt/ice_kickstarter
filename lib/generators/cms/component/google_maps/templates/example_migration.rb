class CreateGoogleMapsExample < ::RailsConnector::Migrations::Migration

  def up
    create_obj(
      _path: "<%= map_path %>/box_google_map",
      _obj_class: 'BoxGoogleMaps',
      title: 'BoxGoogleMap',
      body: 'Inhalt von BoxGoogleMap',
      box_google_maps_center_latitude: '13.40945',
      box_google_maps_center_longitude: '52.520803',
      box_google_maps_center_zoom_level: '1',
      box_google_maps_map_type: 'ROADMAP'
    )

    create_obj(
      _path: "<%= map_path %>/box_google_map/pin",
      _obj_class: 'GoogleMapsPin',
      title: 'GoogleMapsPin',
      body: 'Berliner Fernsehturm',
      google_maps_pin_longitude: '13.40945',
      google_maps_pin_latitude: '52.520803'
    )
  end
end