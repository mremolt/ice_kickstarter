module Cms
  module Generators
    module Component
      class NewrelicGenerator < ::Rails::Generators::NamedBase
        source_root File.expand_path('../templates', __FILE__)

        def include_gemfile
          gem_group :production, :staging do
            gem 'newrelic_rpm'
          end
        end

        def create_template_file
          template('newrelic.yml.erb', File.join('deploy/templates', 'newrelic.yml.erb'))
        end

        def append_after_restart_file
          append_file('deploy/after_restart.rb') do
            File.read(find_in_source_paths('after_restart.rb'))
          end
        end

        def append_before_symlink_file
          append_file('deploy/before_symlink.rb') do
            File.read(find_in_source_paths('before_symlink.rb'))
          end
        end
      end
    end
  end
end