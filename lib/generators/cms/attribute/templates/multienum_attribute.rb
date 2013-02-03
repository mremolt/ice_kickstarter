module Cms
  module Attributes
    module <%= class_name %>
      def <%= file_name %>
        self[:<%= file_name %>] || []
      end
    end
  end
end