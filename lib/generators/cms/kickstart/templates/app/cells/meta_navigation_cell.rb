class MetaNavigationCell < Cell::Rails
  helper :cms

  cache(:show, :expires_in => 5.minutes) do |cell, page, current_user|
    [
      cell.session[:edit_marker],
      RailsConnector::Workspace.current.revision_id,
      page && page.homepage.id,
      current_user && current_user.id,
    ]
  end

  def show(page, current_user)
    @current_user = current_user

    @login_page = page.homepage.login_page
    @search_page = page.homepage.search_page

    render
  end
end