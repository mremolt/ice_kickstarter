module Cms
  module Attributes
    module RedirectAfterLoginLink
      def redirect_after_login_link_attribute
        :redirect_after_login_link
      end

      def default_redirect_after_login_link
        RailsConnector::LinkList.new(nil)
      ensure
        Cms::Errors::MissingAttribute.notify(self, __FILE__)
      end

      def redirect_after_login_link
        self[redirect_after_login_link_attribute] || default_redirect_after_login_link
      end

      def redirect_after_login_link?
        redirect_after_login_link.present?
      end

      def redirect_after_login
        redirect_after_login_link.destination_objects.first
      end
    end
  end
end