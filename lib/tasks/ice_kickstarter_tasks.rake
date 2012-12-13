class Deployment
  include FileUtils

  def status
    sh "curl -X GET #{url}/deployments/current?token=#{api_key}", :verbose => true

    puts
  end

  def live
    sh "git fetch", :verbose => true

    if %x(git rev-parse origin/staging).strip == %x(git rev-parse origin/deploy).strip
      sh "curl -X POST #{url}/deployments?token=#{api_key}", :verbose => true

      puts
    else
      sh 'rake assets:precompile && rake assets:clean'
      sh 'git push origin origin/staging:deploy', :verbose => true
    end
  end

  def staging
    sh 'rake assets:precompile && rake assets:clean'
    sh 'git push origin master:staging', :verbose => true

    puts 'Now tell Anne to click "deploy"'
  end

  private

  def url
    config['url']
  end

  def api_key
    config['api_key']
  end

  def config
    YAML.load_file(File.join(Rails.root, 'config/deploy.yml'))
  end
end

namespace :ice do
  namespace :deploy do
    desc 'Deploys to live cloud: staging -> deploy'
    task :live do
      Deployment.new.live
    end

    desc 'Deploys to staging cloud: master -> staging'
    task :staging do
      Deployment.new.staging
    end

    desc 'Gets status information of the last deployment'
    task :status do
      Deployment.new.status
    end
  end

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