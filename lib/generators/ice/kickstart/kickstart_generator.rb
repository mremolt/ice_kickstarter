require 'uri'

module Ice
  module Generators
    class KickstartGenerator < ::Rails::Generators::Base
      class_option :config, :type => :string, :aliases => '-c', :desc => 'Path to...', :required => true

      def read_config_file
        @configuration ||= begin
          if path = options['config']
            contents = if URI(path).is_a?(URI::HTTP)
              open(path, 'Accept' => 'application/json') { |io| io.read }
            else
              File.read(path)
            end

            configuration = JSON(contents)

            configuration.each do |generator|
              name = generator['name']
              options = Array(generator['options'])

              generate(name, options)
            end
          end
        end
      end
    end
  end
end