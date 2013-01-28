class GoogleAnalytics < ::RailsConnector::Obj
  def anonymize_ip?
    self[:anonymize_ip] == 'Yes'
  end

  def tracking_id
    self[:tracking_id] || ''
  end
end