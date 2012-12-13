module Ice
  module Generators
    class ScaffoldGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('../templates', __FILE__)

      def generate_model
        invoke 'ice:model', [file_name]
      end

      def generate_controller
        invoke 'ice:controller', [file_name]
      end
    end
  end
end