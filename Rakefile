#!/usr/bin/env rake

begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'yard'
require 'rake/testtask'

YARD::Rake::YardocTask.new

gemspec = eval(File.read('ice_kickstarter.gemspec'))

desc 'Builds the gem'
task :gem do
  Gem::Builder.new(gemspec).build
end

desc 'Installs the gem'
task :install => :gem do
  sh "gem install ice_kickstarter-#{gemspec.version}.gem --no-rdoc --no-ri"
end

Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

task :default => :test