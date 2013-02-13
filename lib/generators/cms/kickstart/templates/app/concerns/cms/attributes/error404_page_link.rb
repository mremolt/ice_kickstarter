module Cms
  module Attributes
    module Error404PageLink
      def error_404_page_link_attribute
        :error_404_page_link
      end

      def default_error_404_page_link
        RailsConnector::LinkList.new(nil)
      ensure
        Cms::Errors::MissingAttribute.notify(self, __FILE__)
      end

      def error_404_page_link
        self[error_404_page_link_attribute] || default_error_404_page_link
      end

      def error_404_page_link?
        error_404_page_link.present?
      end

      def error_404_page
        error_404_page_link.destination_objects.first
      end
    end
  end
end