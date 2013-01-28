require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/component/google_analytics/google_analytics_generator.rb'

describe Cms::Generators::Component::GoogleAnalyticsGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp', __FILE__)

  before do
    prepare_destination
    prepare_environments
    run_generator
  end

  def prepare_environments
    environments_path = "#{destination_root}/app/views/layouts/"

    mkdir_p(environments_path)

    File.open("#{environments_path}application.html.haml", 'w') { |f| f.write("= javascript_include_tag 'application'") }
  end

  it 'creates helper file' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'helpers' do
          file 'google_analytics_helper.rb'
        end
      end
    }
  end

  it 'creates model file' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'models' do
          file 'google_analytics.rb'
        end
      end
    }
  end

  it 'creates partial file' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'views' do
          directory 'layouts' do
            directory 'google_analytics' do
              file '_google_analytics.html.erb'
            end
          end
        end
      end
    }
  end
end