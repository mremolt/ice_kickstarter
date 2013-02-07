require 'generators/cms/migration'

module Cms
  module Generators
    module Component
      class ProfilePageGenerator < ::Rails::Generators::Base
        include Migration

        class_option :homepage_path,
          :type => :string,
          :default => '/website/de',
          :desc => 'Path to a CMS homepage, for which to create the contact form.'

        source_root File.expand_path('../templates', __FILE__)

        def copy_app_directory
          directory('app')
          directory('config')
          directory('spec')
        end

        def add_email_validation
          gem('valid_email', '0.0.4')
        end

        def add_country_select
          gem('localized_country_select', '>= 0.9.2')
        end

        def import_countries
          run('rake import:country_select LOCALE=de')
          run('rake import:country_select LOCALE=en')
        end

        def extend_homepage
          file = 'app/models/homepage.rb'
          insert_point = "class Homepage < Obj\n"

          data = []

          data << '  include Cms::Attributes::ProfilePageLink'
          data << ''

          data = data.join("\n")

          insert_into_file(file, data, :after => insert_point)
        end

        def extend_cell
          file = 'app/cells/meta_navigation_cell.rb'
          insert_point = "@search_page = page.homepage.search_page\n"

          data = []

          data << '    @profile_page = page.homepage.profile_page'
          data << ''

          data = data.join("\n")

          insert_into_file(file, data, :after => insert_point)
        end

        def extend_view
          file = 'app/cells/meta_navigation/show.html.haml'
          insert_point = '= display_title(@search_page)'

          data = []

          data << "\n"
          data << '    - if @current_user.logged_in?'
          data << '      %li'
          data << '        = link_to(cms_path(@profile_page)) do'
          data << '          = display_title(@profile_page)'

          data = data.join("\n")

          insert_into_file(file, data, :after => insert_point)
        end

        def create_migration
          validate_obj_class(class_name)

          migration_template('migration.rb', 'cms/migrate/create_profile_page.rb')

          if behavior == :invoke
            log(:migration, 'Make sure to run "rake cms:migrate" to apply CMS changes and "bundle" to install new gem.')
          end
        rescue DuplicateResourceError
        end

        private

        def homepage_path
          options[:homepage_path]
        end

        def class_name
          'ProfilePage'
        end

      end
    end
  end
end
#
#        def create_structure_migration_file
#          Rails::Generators.invoke('cms:attribute', ['profile_page', '--type=linklist'])
#          Rails::Generators.invoke('cms:model', ['ProfilePage', '--title=Page: Profile', '--attributes=show_in_navigation'])
#
#          migration_template('create_profilepage_structure.rb', 'cms/migrate/create_profilepage_structure.rb')
#        end

