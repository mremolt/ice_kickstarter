require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/ice/model/model_generator'

describe Ice::Generators::ModelGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../tmp', __FILE__)
  arguments ['news']

  before do
    prepare_destination
    run_generator
  end

  it 'generates news model' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'models' do
          file 'news.rb' do
            contains 'class News < Obj'
          end
        end
      end
    }
  end
end