require 'rake'
require 'rake/tasklib'

require 'ice_kickstarter/rake/configuration_helper'

module IceKickstarter
  module Rake
    class IntegrationTask < ::Rake::TaskLib
      attr_reader :app_path

      def initialize
        @app_path = 'tmp/test_app'

        namespace :test do
          desc 'Run Kickstarter Integration Tests'
          task :integration do
            prepare_directory
            create_configuration_files
            create_application
            call_generators
            run_tests
          end
        end
      end

      private

      def prepare_directory
        rm_rf(app_path)
        mkdir_p("#{app_path}/config")
      end

      def create_configuration_files
        file = "#{ENV['HOME']}/.config/infopark/kickstarter.yml"

        ConfigurationHelper.new(file, :cms, "#{app_path}/config/rails_connector.yml").write
        ConfigurationHelper.new(file, :crm, "#{app_path}/config/custom_cloud.yml").write
      end

      def create_application
        Bundler.with_clean_env do
          sh "rails new #{app_path} --skip-test-unit --skip-active-record --template template.rb"
        end
      end

      def call_generators
        Bundler.with_clean_env do
          sh "cd #{app_path} && bundle exec rails generate cms:model news"
        end
      end

      def run_tests
        Bundler.with_clean_env do
          sh "cd #{app_path} && bundle exec rake spec"
        end
      end
    end
  end
end