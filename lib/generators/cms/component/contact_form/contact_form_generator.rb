require 'generators/cms/migration'

module Cms
  module Generators
    module Component
      class ContactFormGenerator < ::Rails::Generators::Base
        include Migration

        source_root File.expand_path('../templates', __FILE__)

        def copy_app_directory
          directory('app')
          directory('config')
          directory('spec')
        end

        def add_email_validation
          gem('valid_email', '0.0.4')
        end

        def extend_homepage
          file = 'app/models/homepage.rb'
          insert_point = "class Homepage < Obj\n"

          data = []

          data << '  include Cms::Attributes::ContactPageLink'
          data << ''

          data = data.join("\n")

          insert_into_file(file, data, :after => insert_point)
        end

        def extend_cell
          file = 'app/cells/meta_navigation_cell.rb'
          insert_point = "@search_page = page.homepage.search_page\n"

          data = []

          data << '    @contact_page = page.homepage.contact_page'
          data << ''

          data = data.join("\n")

          insert_into_file(file, data, :after => insert_point)
        end

        def extend_view
          file = 'app/cells/meta_navigation/show.html.haml'
          insert_point = '= display_title(@search_page)'

          data = []

          data << "\n"
          data << '    %li'
          data << '      = link_to(cms_path(@contact_page)) do'
          data << '        = display_title(@contact_page)'

          data = data.join("\n")

          insert_into_file(file, data, :after => insert_point)
        end

        def create_migration
          validate_obj_class(class_name)
          validate_attribute(crm_activity_type_attribute_name)

          migration_template('migration.rb', 'cms/migrate/create_contact_page.rb')

          if behavior == :invoke
            log(:migration, 'Make sure to run "rake cms:migrate" to apply CMS changes.')
          end
        rescue DuplicateResourceError
        end

        private

        def class_name
          'ContactPage'
        end

        def crm_activity_type_attribute_name
          'crm_activity_type'
        end
      end
    end
  end
end