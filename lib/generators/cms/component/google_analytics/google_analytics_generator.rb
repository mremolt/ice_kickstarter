require 'uri'
require 'generators/cms/migration'

module Cms
  module Generators
    module Component
      class GoogleAnalytics < ::Rails::Generators::Base
        include Migration

        source_root File.expand_path('../templates', __FILE__)

        def copy_app_directory
          directory('app')
        end

        def insert_google_analytics_snippet_to_application_view
          insert_into_file(
            "app/views/layouts/application.html.haml",
            :after => "= javascript_include_tag 'application'") do
              "\n\n    = render_google_analytics(@obj.homepage)"
            end
        end

        def create_structure_migration_file
          migration_template('migration.rb', "cms/migrate/create_google_analytics.rb")
        end

        def create_spec_files
          template('spec.rb', File.join('spec/models', "google_analytics_spec.rb"))
        end
      end
    end
  end
end