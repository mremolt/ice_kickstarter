require 'generators/ice/language'

module Ice
  module Generators
    class ScaffoldGenerator < ::Rails::Generators::NamedBase
      include Language

      source_root File.expand_path('../templates', __FILE__)

      def generate_model
        invoke "ice:model", [file_name, "-l #{language}"]
      end

      def generate_controller
        invoke "ice:controller", [file_name, "-l #{language}"]
      end
    end
  end
end