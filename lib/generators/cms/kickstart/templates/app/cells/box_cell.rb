class BoxCell < Cell::Rails
  helper :cms

  build do |page, box|
    "Box::#{box.class}Cell".constantize
  end

  def show(page, box)
    @page = page
    @box = box

    render
  end

  def edit_marker
    if edit_marker?
      render
    end
  end

  private

  def edit_marker?
    Filters::EnvironmentDetection.preview_environment?
  end
end