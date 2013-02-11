class CreateGoogleMaps < ::RailsConnector::Migrations::Migration

  def up
    create_box_obj_class
    create_pin_obj_class
  end

  private

  def create_pin_obj_class
    create_attribute(name: '<%= pin_latitude_attribute_name %>', title: 'Latitude', type: :string)
    create_attribute(name: '<%= pin_longitude_attribute_name %>', title: 'Longitude', type: :string)

    params = {
      name: '<%= pin_class_name %>',
      title: 'GoogleMaps: Pin',
      type: :publication,
      attributes: [
        '<%= pin_latitude_attribute_name %>',
        '<%= pin_longitude_attribute_name %>'
      ]
    }

    create_obj_class(params)
  end

  def create_box_obj_class
    create_attribute(
      name: '<%= box_map_type_attribute_name %>',
      title: 'Map Typ',
      type: :enum,
      values: [
        'ROADMAP',
        'SATELLITE',
        'HYBRID',
        'TERRAIN'
      ]
    )

    create_attribute(
      name: '<%= box_center_latitude_attribute_name %>',
      title: 'Latitude Center',
      type: :string
    )

    create_attribute(
      name: '<%= box_center_longitude_attribute_name %>',
      title: 'Longitude Center',
      type: :string
    )

    create_attribute(
      name: '<%= box_center_zoom_level_attribute_name %>',
      title: 'Zoomlevel',
      type: :string
    )

    create_obj_class(
      name: '<%= map_class_name %>',
      title: 'Box: GoogleMaps',
      type: :publication,
      attributes: [
        '<%= box_map_type_attribute_name %>',
        '<%= box_center_latitude_attribute_name %>',
        '<%= box_center_longitude_attribute_name %>',
        '<%= box_center_zoom_level_attribute_name %>'
      ]
    )
  end
end