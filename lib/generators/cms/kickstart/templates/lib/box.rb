module Box
  def page
    if parent
      parent.page
    end
  end
end