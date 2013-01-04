require 'uri'

module Cms
  module Generators
    class KickstartGenerator < ::Rails::Generators::Base
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

      def initialize_rspec
        gem('rspec-rails')
        generate('rspec:install')
      end
    end
  end
end