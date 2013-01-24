class FooterCell < Cell::Rails
  helper :cms

  cache :show, :expires_in => 10.minutes do |cell, page|
    [cell.session[:edit_marker], RailsConnector::Workspace.current.revision_id, page && page.homepage.id]
  end

  def show
    render
  end
end