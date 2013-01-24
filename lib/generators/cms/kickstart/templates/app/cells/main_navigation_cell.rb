class MainNavigationCell < Cell::Rails
  helper :cms

  cache :show, :expires_in => 5.minutes do |cell, page|
    [cell.session[:edit_marker], RailsConnector::Workspace.current.revision_id, page && page.homepage.id]
  end

  def show(page)
    homepage = page.homepage
    @level1 = [homepage] + homepage.sorted_toclist.select { |obj| Page === obj }

    render
  end

  cache :highlight, :expires_in => 1.hour do |cell, page|
    [cell.session[:edit_marker], RailsConnector::Workspace.current.revision_id, page && page.id]
  end

  def highlight(page)
    @active = page.main_nav_item
    render
  end

  def workspace_toggle
    @workspaces = RailsConnector::CmsRestApi.get('workspaces')['results']

    @current_workspace = @workspaces.detect do |workspace|
      workspace['id'] == RailsConnector::Workspace.current.id
    end

    @workspaces.each do |workspace|
      workspace['title'] ||= 'Published'
    end

    render
  end
end