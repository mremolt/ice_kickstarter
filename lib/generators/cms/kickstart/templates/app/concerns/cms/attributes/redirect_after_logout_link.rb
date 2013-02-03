module Cms
  module Attributes
    module RedirectAfterLogoutLink
      def redirect_after_logout_link_attribute
        :redirect_after_logout_link
      end

      def default_redirect_after_logout_link
        RailsConnector::LinkList.new(nil)
      ensure
        Cms::Errors::MissingAttribute.notify(self, __FILE__)
      end

      def redirect_after_logout_link
        self[redirect_after_logout_link_attribute] || default_redirect_after_logout_link
      end

      def redirect_after_logout_link?
        redirect_after_logout_link.present?
      end

      def redirect_after_logout
        redirect_after_logout_link.destination_objects.first
      end
    end
  end
end