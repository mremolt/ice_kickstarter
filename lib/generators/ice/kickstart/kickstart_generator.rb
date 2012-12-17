require 'uri'

module Ice
  module Generators
    class KickstartGenerator < ::Rails::Generators::Base
      argument :path, :type => :string

      def read_config_file
        @configuration ||= begin
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
      end
    end
  end
end