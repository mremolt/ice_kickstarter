require 'uri'
require 'generators/cms/migration'

module Cms
  module Generators
    class KickstartGenerator < ::Rails::Generators::Base
      include Migration

      source_root File.expand_path('../templates', __FILE__)
      class_option :configuration_path, :type => :string, :default => nil, :desc => 'Path to a JSON configuration file.'

      def initialize(args = [], options = {}, config = {})
        options << '--force'

        super(args, options, config)
      end

      def read_config_file
        path = options[:configuration_path]

        if path
          contents = if URI(path).is_a?(URI::HTTP)
            open(path, 'Accept' => 'application/json') { |io| io.read }
          else
            File.read(path)
          end

          configuration = JSON(contents)

          configuration.each do |generator|
            name = generator['name']
            options = Array(generator['options'])

            Rails::Generators.invoke(name, options, :behavior => behavior)
          end
        end
      end

      def include_pry
        gem_group :test, :development do
          gem('pry-rails')
        end
      end

      def install_rspec
        gem_group :test, :development do
          gem('rspec-rails')
        end

        generate('rspec:install')
      end

      def include_and_configure_haml
        gem('haml-rails')

        application_erb_file = 'app/views/layouts/application.html.erb'

        if File.exist?(application_erb_file)
          remove_file application_erb_file
        end
      end

      def install_twitter_bootstrap
        gem_group :assets do
          gem('twitter-bootstrap-rails', '2.1.3')
        end
      end

      def set_timezone
        gsub_file(
          'config/application.rb',
          "# config.time_zone = 'Central Time (US & Canada)'",
          "config.time_zone = 'Berlin'"
        )

        puts "set timezone to 'Berlin'"
      end

      def set_default_language
        gsub_file(
          'config/application.rb',
          "# config.i18n.default_locale = :de",
          "config.i18n.default_locale = :de"
        )

        puts "set default language to 'de'"
      end

      def rails_connector_monkey_patch
        template('date_attribute.rb', 'config/initializers/date_attribute.rb')
      end

      def configure_editmarker
        template('preview.js.coffee', 'app/assets/javascripts/preview.js.coffee')
      end

      def create_structure_migration_file
        # Keep Rails::Generators Namespace, otherwise generators cannot be called
        # multiple times.
        Rails::Generators.invoke('cms:attribute', ['show_in_navigation', '--type=enum', '--values=Yes', 'No'])

        Rails::Generators.invoke('cms:attribute', ['error_404_page', '--type=linklist'])
        Rails::Generators.invoke('cms:attribute', ['login_page', '--type=linklist'])
        Rails::Generators.invoke('cms:attribute', ['search_page', '--type=linklist'])
        Rails::Generators.invoke('cms:attribute', ['locale', '--type=string'])
        Rails::Generators.invoke('cms:scaffold', ['Homepage', 'error_404_page', 'login_page', 'search_page', 'locale', 'show_in_navigation'])

        Rails::Generators.invoke('cms:model', ['Root', 'show_in_navigation'])
        Rails::Generators.invoke('cms:model', ['Website', 'show_in_navigation'])
        Rails::Generators.invoke('cms:scaffold', ['ContentPage', 'show_in_navigation'])
        Rails::Generators.invoke('cms:scaffold', ['ErrorPage', 'show_in_navigation'])
        Rails::Generators.invoke('cms:scaffold', ['LoginPage', 'show_in_navigation'])
        Rails::Generators.invoke('cms:scaffold', ['SearchPage', 'show_in_navigation'])

        Rails::Generators.invoke('cms:attribute', ['source', '--type=linklist'])
        Rails::Generators.invoke('cms:attribute', ['caption', '--type=string'])
        Rails::Generators.invoke('cms:attribute', ['sort_key', '--type=string'])
        Rails::Generators.invoke('cms:model', ['BoxText', 'sort_key', 'show_in_navigation'])
        Rails::Generators.invoke('cms:model', ['BoxImage', 'source', 'caption', 'sort_key', 'show_in_navigation'])

        migration_template('create_structure.rb', 'cms/migrate/create_structure.rb')

        route("match ':id/login' => 'login_page#index', :as => 'login_page'")
      end

      def copy_app_directory
        directory('app')
        directory('lib')
        directory('config')
      end

      def create_box_model
        gem('cells')

        template('cells_error_handling.rb', 'config/initializers/cells.rb')
      end

      def bundle
        Bundler.with_clean_env do
          run('bundle')
        end
      end

      private

      def tenant_name
        content = File.read('config/rails_connector.yml')

        YAML.load(content)['cms_api']['http_host']
      end
    end
  end
end