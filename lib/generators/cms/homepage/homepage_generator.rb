require 'uri'
require 'generators/cms/migration'

module Cms
  module Generators
    class HomepageGenerator < ::Rails::Generators::NamedBase
      include Migration

      source_root File.expand_path('../templates', __FILE__)

      class_option :title, :type => :string, :default => 'Homepage', :desc => 'The title of the new homepage.'

      def create_structure_migration_file
        migration_template('migration.rb', "cms/migrate/create_#{file_name}_homepage.rb")
      end

      private

      def title
        options[:title]
      end
    end
  end
end