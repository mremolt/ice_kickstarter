class GoogleMapsPin < Obj

  def longitude
    self.google_maps_pin_longitude
  end

  def latitude
    self.google_maps_pin_latitude
  end

  def as_json(options = {})
    {
      :title => self.title,
      :body => self.body,
      :longitude => self.longitude.to_f,
      :latitude => self.latitude.to_f
    }
  end

end