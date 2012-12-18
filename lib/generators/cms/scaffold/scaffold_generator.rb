module Cms
  module Generators
    class ScaffoldGenerator < ::Rails::Generators::NamedBase
      source_root File.expand_path('../templates', __FILE__)

      def generate_model
        invoke 'cms:model', [file_name]
      end

      def generate_controller
        invoke 'cms:controller', [file_name]
      end
    end
  end
end