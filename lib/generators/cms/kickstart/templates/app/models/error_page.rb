class ErrorPage < ::RailsConnector::Obj
  include Page

  def show_in_navigation?
    false
  end
end