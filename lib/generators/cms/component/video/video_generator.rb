require 'generators/cms/migration'

module Cms
  module Generators
    module Component
      class VideoGenerator < ::Rails::Generators::Base
        include Migration

        class_option :homepage_path,
          type: :string,
          default: '/website/de',
          desc: 'Path to a CMS homepage, for which to create the contact form.'

        source_root File.expand_path('../templates', __FILE__)

        def copy_app_directory
          directory('app')
          directory('config')
          directory('spec')
        end

        def create_migration
          validate_obj_class(class_name)
          validate_attribute(crm_activity_type_attribute_name)

          migration_template('migration.rb', 'cms/migrate/create_video.rb')

          if behavior == :invoke
            log(:migration, 'Make sure to run "rake cms:migrate" to apply CMS changes and "bundle" to install new gem.')
          end
        rescue DuplicateResourceError
        end

        private

        def class_name
          'Video'
        end
      end
    end
  end
end