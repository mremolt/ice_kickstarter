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
    app_path = 'tmp/test_app'
    rm_rf app_path
    mkdir_p app_path
    sh "rsync -a config #{app_path}/"

    Bundler.with_clean_env do
      sh "rails new #{app_path} --skip-test-unit --skip-active-record --template template.rb"
      sh "cd #{app_path} && bundle exec rails generate cms:model news"
      sh "cd #{app_path} && bundle exec rake spec"
    end
  end
end