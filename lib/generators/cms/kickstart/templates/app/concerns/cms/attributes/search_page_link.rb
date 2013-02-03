module Cms
  module Attributes
    module SearchPageLink
      def search_page_link_attribute
        :search_page_link
      end

      def default_search_page_link
        RailsConnector::LinkList.new(nil)
      ensure
        Cms::Errors::MissingAttribute.notify(self, __FILE__)
      end

      def search_page_link
        self[search_page_link_attribute] || default_search_page_link
      end

      def search_page_link?
        search_page_link.present?
      end

      def search_page
        search_page_link.destination_objects.first
      end
    end
  end
end