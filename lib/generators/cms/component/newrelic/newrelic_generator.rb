module Cms
  module Generators
    module Component
      class NewrelicGenerator < ::Rails::Generators::Base
        source_root File.expand_path('../templates', __FILE__)

        def include_gemfile
          gem_group :production, :staging do
            gem 'newrelic_rpm'
          end
        end

        def create_template_file
          template('newrelic.yml.erb', File.join('deploy/templates', 'newrelic.yml.erb'))
        end

        # TODO
        def append_after_restart_file
          # append_file('deploy/after_restart.rb') do
          #   run "bundle exec rake environment airbrake:deploy TO=#{new_resource.environment['RAILS_ENV']}"

          #   user = %x(whoami).strip
          #   revision = %x(git rev-parse HEAD).strip
          #   newrelic_deploy_key = node["custom_cloud"]["newrelic"]["deploy_key"]
          #   newrelic_app_name = case new_resource.environment['RAILS_ENV']
          #                       when 'staging'
          #                         'TODO Website (Staging)'
          #                       else
          #                         'TODO Website'
          #                       end
          #   run %(curl -H "x-api-key:#{newrelic_deploy_key}" -d "deployment[app_name]=#{newrelic_app_name}" -d "deployment[description]=#{new_resource.environment['RAILS_ENV']}" -d "deployment[revision]='#{revision}'" -d "deployment[user]='#{user}'"  https://rpm.newrelic.com/deployments.xml)
          # end
        end

        # TODO
        def append_before_symlink_file
          # append_file('deploy/before_symlink') do
          #   template "#{release_path}/config/newrelic.yml" do
          #     local true
          #     owner 'deploy'
          #     group 'root'
          #     mode 0664
          #     source "#{release_path}/deploy/templates/newrelic.yml.erb"
          #   end
          # end
        end
      end
    end
  end
end