require 'uri'
require 'generators/cms/migration'

module Cms
  module Generators
    class KickstartGenerator < ::Rails::Generators::Base
      include Migration

      source_root File.expand_path('../templates', __FILE__)
      class_option :configuration_path, :type => :string, :default => nil, :desc => 'Path to a JSON configuration file.'

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

      def install_rspec
        generate('rspec:install')
      end

      def configure_haml
        template('application.html.haml', File.join('app/views/layouts', 'application.html.haml'))

        application_erb_file = 'app/views/layouts/application.html.erb'

        if File.exist?(application_erb_file)
          remove_file application_erb_file
        end
      end

      def install_twitter_bootstrap
        # TODO
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

      def create_structure_migration_file
        # Keep Rails::Generators Namespace, otherwise generators cannot be called
        # multiple times.
        Rails::Generators.invoke('cms:attribute', ['error_404_page', 'type=linklist'])
        Rails::Generators.invoke('cms:attribute', ['locale', 'type=string'])

        Rails::Generators.invoke('cms:model', ['Root'])
        Rails::Generators.invoke('cms:model', ['Website'])
        Rails::Generators.invoke('cms:scaffold', ['Homepage', 'locale', 'error_404_page'])
        Rails::Generators.invoke('cms:scaffold', ['ContentPage'])
        Rails::Generators.invoke('cms:scaffold', ['ErrorPage'])

        migration_template('create_structure.rb', 'cms/migrate/create_structure.rb')
      end

      def create_box_model
        # TODO
      end
    end
  end
end