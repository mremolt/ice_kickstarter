require 'generators/cms/migration'

module Cms
  module Generators
    module Component
      class GoogleAnalyticsGenerator < ::Rails::Generators::Base
        include Migration

        source_root File.expand_path('../templates', __FILE__)

        class_option :anonymize_ip_default,
          :type => :string,
          :default => 'No',
          :desc => 'Default anonymize ip setting. (Yes | No)',
          :banner => 'VALUE'

        class_option :tracking_id_default,
          :type => :string,
          :default => '',
          :desc => 'Default tracking id setting.',
          :banner => 'ID'

        def copy_app_directory
          directory('app')
          directory('spec')
        end

        def insert_google_analytics
          file = 'app/views/layouts/application.html.haml'
          insert_point = "= javascript_include_tag('application')"

          data = []

          data << "\n"
          data << '    = render_cell(:google_analytics, :show, @obj.homepage)'

          data = data.join("\n")

          insert_into_file(file, data, :after => insert_point)
        end

        def create_migration
          migration_template('migration.rb', 'cms/migrate/create_google_analytics.rb')

          if behavior == :invoke
            log(:migration, 'Make sure to run "rake cms:migrate" to apply CMS changes and set a Tracking ID.')
          end
        end

        private

        def anonymize_ip_default
          options[:anonymize_ip_default]
        end

        def tracking_id_default
          options[:tracking_id_default]
        end
      end
    end
  end
end