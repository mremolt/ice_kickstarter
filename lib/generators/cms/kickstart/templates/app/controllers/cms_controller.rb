class CmsController < RailsConnector::DefaultCmsController
  before_filter Filters::HostnameSelection

  # Delay filter until the RailsConnector has loaded the current object.
  skip_before_filter :set_locale
  before_filter :set_locale

  def index
  end
end