module Cms
  module Generators
    class ModelGenerator < ::Rails::Generators::NamedBase
      source_root File.expand_path('../templates', __FILE__)

      def create_model_file
        template 'model.rb', File.join('app/models', "#{file_name}.rb")
      end

      def create_spec_files
        template 'spec.rb', File.join('spec/models', "#{file_name}_spec.rb")
      end
    end
  end
end