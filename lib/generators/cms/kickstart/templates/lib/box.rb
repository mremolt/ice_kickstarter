module Box

  def page
    parent.page if parent
  end

end
