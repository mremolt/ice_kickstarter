class FooterCell < Cell::Rails
  helper :cms

  cache :show, :expires_in => 10.minutes do |cell, page|
    [
      Filters::EnvironmentDetection.preview_environment?,
      RailsConnector::Workspace.current.revision_id,
      page && page.homepage.id,
    ]
  end

  def show
    render
  end
end