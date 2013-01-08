module Cms
  module Generators
    module Component
      class AirbrakeGenerator < ::Rails::Generators::Base
        source_root File.expand_path('../templates', __FILE__)

        def include_gemfile
          gem('airbrake')
        end

        def create_initializer_file
          template('airbrake.rb', File.join('config/initializers', 'airbrake.rb'))
        end
      end
    end
  end
end