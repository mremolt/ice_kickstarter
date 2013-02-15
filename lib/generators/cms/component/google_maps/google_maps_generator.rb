require 'generators/cms/migration'

module Cms
  module Generators
    module Component
      class GoogleMapsGenerator < ::Rails::Generators::Base
        include Migration

        class_options with_example_to_path: nil

        source_root File.expand_path('../templates', __FILE__)

        def copy_app_directory
          directory('app')
          directory('spec')
        end

        def create_migration
          validate_obj_class(map_class_name)
          validate_obj_class(pin_class_name)

          validate_attribute(box_map_type_attribute_name)
          validate_attribute(pin_latitude_attribute_name)
          validate_attribute(pin_longitude_attribute_name)
          validate_attribute(box_center_latitude_attribute_name)
          validate_attribute(box_center_longitude_attribute_name)
          validate_attribute(box_center_zoom_level_attribute_name)

          migration_template('migration.rb', 'cms/migrate/create_google_maps.rb')

          if behavior == :invoke
            log(:migration, 'Make sure to run "rake cms:migrate" to apply CMS changes')
          end

          rescue Cms::Generators::DuplicateResourceError
        end

        def update_routes
          route("match 'google_maps/:id' => 'google_maps#show', as: 'google_map'")
        end

        def update_application_layout
          file = 'app/views/layouts/application.html.haml'
          insert_point = "= javascript_include_tag('application')"

          data = []
          data << "\n"
          data << "    = javascript_include_tag 'http://maps.google.com/maps/api/js?sensor=false'"
          data = data.join("\n")

          insert_into_file(file, data, after: insert_point)
        end

        def update_application_js
          file = 'app/assets/javascripts/application.js'
          insert_point = "//= require infopark_rails_connector"

          data = []
          data << "\n"
          data << '//= require google_maps/base'
          data << "\n"
          data << '$(document).ready(function() {'
          data << "  window.googleMapApp = new window.GoogleMap.App('#map_canvas', 'data-url');"
          data << '});'
          data = data.join("\n")

          insert_into_file(file, data, after: insert_point)
        end

        def add_defaults
          if with_example
            migration_template('example_migration.rb', 'cms/migrate/create_google_maps_example.rb')
          end
        end

        private

        def with_example
          options[:with_example_to_path].present?
        end

        def map_path
          options[:with_example_to_path]
        end

        def map_class_name
          'BoxGoogleMaps'
        end

        def pin_class_name
          'GoogleMapsPin'
        end

        def box_center_latitude_attribute_name
          'box_google_maps_center_latitude'
        end

        def box_center_longitude_attribute_name
          'box_google_maps_center_longitude'
        end

        def box_center_zoom_level_attribute_name
          'box_google_maps_center_zoom_level'
        end

        def box_map_type_attribute_name
          'box_google_maps_map_type'
        end

        def pin_longitude_attribute_name
          'google_maps_pin_longitude'
        end

        def pin_latitude_attribute_name
          'google_maps_pin_latitude'
        end
      end
    end
  end
end