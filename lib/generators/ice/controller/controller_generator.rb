module Ice
  module Generators
    class ControllerGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('../templates', __FILE__)

      def create_controller_file
        template 'controller.rb', File.join('app/controllers', "#{file_name}_controller.rb")
      end

      def copy_view_file
        template 'index.html.haml', File.join('app/views/', file_name, 'index.html.haml')
      end
    end
  end
end