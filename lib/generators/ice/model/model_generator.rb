require 'generators/ice/language'

module Ice
  module Generators
    class ModelGenerator < ::Rails::Generators::NamedBase
      include Language

      source_root File.expand_path('../templates', __FILE__)

      def create_model_file
        template "#{language}/model.rb", File.join('app/models', "#{file_name}.rb")
      end
    end
  end
end