#!/usr/bin/env rake

require 'bundler/setup'
Bundler::GemHelper.install_tasks

require 'yard'
YARD::Rake::YardocTask.new

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

task :default => :spec

namespace :spec do
  task :integration do
    app_path = 'spec/tmp/test_app'

    rm_rf app_path
    sh "rails generate app #{app_path} --skip-test-unit --skip-bundle"

    chdir app_path do
      Bundler.with_clean_env do
        sh "bundle --local || bundle"

        sh "bundle exec rails generate cms:model news"

        sh "bundle exec rake spec"
      end
    end
  end
end