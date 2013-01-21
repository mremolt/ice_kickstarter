class Publication < Obj
  # Publication is only a container.
  def page
    parent.page if parent
  end
end