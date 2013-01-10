class LandingPage < Obj
  include Page

  def overview_pages
    sorted_toclist.select {|obj| OverviewPage === obj}
  end

  def main_nav_item
    self
  end

end
