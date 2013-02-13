#!/usr/bin/env rake

require 'bundler/setup'
Bundler::GemHelper.install_tasks

require 'yard'
YARD::Rake::YardocTask.new

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

require 'ice_kickstarter/rake/integration_task'
IceKickstarter::Rake::IntegrationTask.new

task default: :spec