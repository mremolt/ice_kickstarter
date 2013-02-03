module Cms
  module Attributes
    module <%= class_name %>
      def <%= file_name %>_attribute
        :<%= file_name %>
      end

      def default_<%= file_name %>
        RailsConnector::LinkList.new(nil)
      ensure
        Cms::Errors::MissingAttribute.notify(self, __FILE__)
      end

      def <%= file_name %>
        self[<%= file_name %>_attribute] || default_<%= file_name %>
      end

      def <%= file_name %>?
        <%= file_name %>.present?
      end

      def error_404_page
        <%= file_name %>.destination_objects.first
      end
    end
  end
end