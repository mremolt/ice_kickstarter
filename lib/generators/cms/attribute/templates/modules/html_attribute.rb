module Cms
  module Attributes
    module <%= class_name %>
      def <%= file_name %>
        self[:<%= file_name %>] || ''.html_safe
      end
    end
  end
end