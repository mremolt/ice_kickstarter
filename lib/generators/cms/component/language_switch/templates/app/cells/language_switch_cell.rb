class LanguageSwitchCell < Cell::Rails
  def show(page)
    @languages = page.website.children()
  	@current_language = page.homepage.locale
    render
  end
end