require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/component/google_maps/google_maps_generator.rb'

describe Cms::Generators::Component::GoogleMapsGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp', __FILE__)

  arguments ['--with_example_to_path=testdirectory']

  before do
    prepare_destination
    prepare_environments
    run_generator
  end

  def prepare_environments
    layouts_environments_path = "#{destination_root}/app/views/layouts/"
    javascripts_environments_path = "#{destination_root}/app/assets/javascripts/"
    config_environments_path = "#{destination_root}/config/"

    mkdir_p(layouts_environments_path)
    mkdir_p(javascripts_environments_path)
    mkdir_p(config_environments_path)

    File.open("#{layouts_environments_path}application.html.haml", 'w') { |f| f.write("= javascript_include_tag('application')") }
    File.open("#{javascripts_environments_path}application.js", 'w') { |f| f.write("//= require infopark_rails_connector") }
    File.open("#{config_environments_path}routes.rb", 'w') { |f| f.write(" ") }
  end

  it 'creates view' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'cells' do
          directory 'box' do
            file 'box_google_maps_cell.rb'

            directory 'box_google_maps' do
              file 'show.html.haml'
            end
          end
        end
      end
    }
  end

  it 'creates model file' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'models' do
          file 'box_google_maps.rb'
          file 'google_maps_pin.rb'
        end
      end
    }
  end

  it 'creates test file' do
    destination_root.should have_structure {
      directory 'spec' do
        directory 'models' do
          file 'box_google_maps.rb'
          file 'google_maps_pin.rb'
        end
      end
    }
  end

  it 'creates migration file' do
    destination_root.should have_structure {
      directory 'cms' do
        directory 'migrate' do
          migration 'create_google_maps'
        end
      end
    }
  end

  it 'creates example migration file' do
    destination_root.should have_structure {
      directory 'cms' do
        directory 'migrate' do
          migration 'create_google_maps_example'
        end
      end
    }
  end
end