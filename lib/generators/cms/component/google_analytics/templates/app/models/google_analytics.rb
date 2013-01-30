class GoogleAnalytics < ::RailsConnector::Obj
  def anonymize_ip?
    self[:google_analytics_anonymize_ip] == 'Yes'
  end

  def tracking_id
    self[:google_analytics_tracking_id] || ''
  end
end