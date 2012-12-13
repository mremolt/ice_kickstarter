require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/ice/controller/controller_generator'

describe Ice::Generators::ControllerGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../tmp', __FILE__)
  arguments ['news']

  before do
    prepare_destination
    run_generator
  end

  it 'generates news controller' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'controllers' do
          file 'news_controller.rb' do
            contains 'class NewsController < CmsController'
          end
        end

        directory 'views' do
          directory 'news' do
            file 'index.html.haml'
          end
        end
      end
    }
  end
end