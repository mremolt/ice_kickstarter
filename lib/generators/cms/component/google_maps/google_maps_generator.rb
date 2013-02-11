require 'generators/cms/migration'

module Cms
  module Generators
    module Component
      class GoogleMapsGenerator < ::Rails::Generators::Base
        include Migration

        source_root File.expand_path('../templates', __FILE__)

        def copy_app_directory
          directory('app')
          #directory('spec')
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

        private

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