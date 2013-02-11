class BoxGoogleMaps < Obj
  include Box

  def pins
    self.toclist.select {|obj| obj.is_a?(GoogleMapsPin)}
  end

  def zoom_level
    self.box_google_maps_center_zoom_level
  end

  def center_latitude
    self.box_google_maps_center_latitude
  end

  def center_longitude
    self.box_google_maps_center_longitude
  end

  def map_type
    self.box_google_maps_map_type
  end

  def as_json(options = {})
    {
      :pins => self.pins.as_json,
      :map_type => self.map_type,
      :zoom_level => self.zoom_level.to_i,
      :center_latitude => self.center_latitude.to_f,
      :center_longitude => self.center_longitude.to_f
    }
  end
end