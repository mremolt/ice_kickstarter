require 'generators/cms/migration'

module Cms
  module Generators
    module Component
      class GoogleAnalyticsGenerator < ::Rails::Generators::Base
        include Migration

        source_root File.expand_path('../templates', __FILE__)

        def copy_app_directory
          directory('app')
          directory('spec')
        end

        def insert_google_analytics_snippet_to_application_view
          file = 'app/views/layouts/application.html.haml'
          insert_into_file(file, :after => "= javascript_include_tag 'application'") do
            "\n\n    = render_google_analytics(@obj.homepage)"
          end
        end

        def create_structure_migration_file
          migration_template('migration.rb', 'cms/migrate/create_google_analytics.rb')
        end
      end
    end
  end
end