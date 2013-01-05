require 'rake'
require 'rake/tasklib'

module IceKickstarter
  module Rake
    class GithubTask < ::Rake::TaskLib
      def initialize
        namespace :cms do
          namespace :github do
            desc 'TODO'
            task :add do
              # Task goes here
            end

            desc 'TODO'
            task :remove do
              # Task goes here
            end

            desc 'TODO'
            task :list do
              # Task goes here
            end
          end

          desc 'TODO'
          task :seed do
            # Task goes here
          end
        end
      end
    end
  end
end