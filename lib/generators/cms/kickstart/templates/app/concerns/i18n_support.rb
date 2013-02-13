module I18nSupport
  extend ActiveSupport::Concern

  included do
    before_filter :set_locale
  end

  private

  def set_locale
    locale = @obj.try(:locale)

    Filters::LocaleSetter.filter(self, locale)
  end
end