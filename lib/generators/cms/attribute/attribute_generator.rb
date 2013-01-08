require 'generators/cms/migration'

module Cms
  module Generators
    class AttributeGenerator < ::Rails::Generators::NamedBase
      include Migration

      source_root File.expand_path('../templates', __FILE__)

      class_option :type,
        :type => :string,
        :aliases => '-t',
        :default => 'string',
        :desc => 'Type of the CMS attribute (string | text | html | enum | multienum | linklist | date).'

      def create_migration_file
        migration_template('migration.rb', "cms/migrate/create_#{file_name}_attribute.rb")
      end

      private

      def type
        options[:type]
      end
    end
  end
end