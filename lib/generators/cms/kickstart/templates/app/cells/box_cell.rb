class BoxCell < Cell::Rails
  helper :application, :cms

  build do |page, box|
    "Box::#{box.class}Cell".constantize
  end

  def show(page, box)
    @page = page
    @box = box

    render
  end

  def edit_marker
    render if session[:edit_marker]
  end
end