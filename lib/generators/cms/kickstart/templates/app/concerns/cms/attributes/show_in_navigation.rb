module Cms
  module Attributes
    module ShowInNavigation
      def show_in_navigation
        self[:show_in_navigation]
      end

      def show_in_navigation?
        show_in_navigation == 'Yes'
      end
    end
  end
end