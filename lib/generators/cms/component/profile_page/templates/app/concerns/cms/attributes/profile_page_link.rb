module Cms
  module Attributes
    module ProfilePageLink
      def profile_page_link_attribute
        :profile_page_link
      end

      def default_profile_page_link
        RailsConnector::LinkList.new(nil)
      ensure
        Cms::Errors::MissingAttribute.notify(self, __FILE__)
      end

      def profile_page_link
        self[profile_page_link_attribute] || default_profile_page_link
      end

      def profile_page_link?
        profile_page_link.present?
      end

      def profile_page
        profile_page_link.destination_objects.first
      end
    end
  end
end