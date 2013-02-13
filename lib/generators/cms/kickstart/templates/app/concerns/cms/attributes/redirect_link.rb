module Cms
  module Attributes
    module RedirectLink
      def redirect_link_attribute
        :redirect_link
      end

      def default_redirect_link
        RailsConnector::LinkList.new(nil)
      ensure
        Cms::Errors::MissingAttribute.notify(self, __FILE__)
      end

      def redirect_link
        self[redirect_link_attribute] || default_redirect_link
      end

      def redirect_link?
        redirect_link.present?
      end

      def redirect
        redirect_link.destination_objects.first
      end
    end
  end
end