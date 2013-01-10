class Rootpub < Obj
  include Page

  def homepage
    self.class.default_homepage
  end

end
