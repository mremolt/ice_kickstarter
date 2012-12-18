require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/component/amazon_ses/amazon_ses_generator'

describe Cms::Generators::Component::AmazonSesGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../tmp', __FILE__)

  before do
    prepare_destination
    run_generator
  end

  it 'creates initializer file' do
    destination_root.should have_structure {
      directory 'config' do
        directory 'initializers' do
          file 'amazon_ses.rb'
        end
      end
    }
  end
end