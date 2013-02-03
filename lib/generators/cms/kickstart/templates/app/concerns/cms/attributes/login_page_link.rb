module Cms
  module Attributes
    module LoginPageLink
      def login_page_link_attribute
        :login_page_link
      end

      def default_login_page_link
        RailsConnector::LinkList.new(nil)
      ensure
        Cms::Errors::MissingAttribute.notify(self, __FILE__)
      end

      def login_page_link
        self[login_page_link_attribute] || default_login_page_link
      end

      def login_page_link?
        login_page_link.present?
      end

      def login_page
        login_page_link.destination_objects.first
      end
    end
  end
end