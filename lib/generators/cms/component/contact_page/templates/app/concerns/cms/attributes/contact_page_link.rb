module Cms
  module Attributes
    module ContactPageLink
      def contact_page_link_attribute
        :contact_page_link
      end

      def default_contact_page_link
        RailsConnector::LinkList.new(nil)
      ensure
        Cms::Errors::MissingAttribute.notify(self, __FILE__)
      end

      def contact_page_link
        self[contact_page_link_attribute] || default_contact_page_link
      end

      def contact_page_link?
        contact_page_link.present?
      end

      def contact_page
        contact_page_link.destination_objects.first
      end
    end
  end
end