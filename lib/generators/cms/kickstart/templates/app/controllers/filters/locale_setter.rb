module Filters
  class LocaleSetter < Base
    class << self
      def filter(controller, locale = nil)
        super(controller)

        I18n.locale = session[:locale] = locale || session[:locale].presence || I18n.default_locale
      end
    end
  end
end