require 'ice_kickstarter/rake/deployment_task'
IceKickstarter::Rake::DeploymentTask.new

require 'ice_kickstarter/rake/github_task'
IceKickstarter::Rake::GithubTask.new

require 'ice_kickstarter/rake/info_task'
IceKickstarter::Rake::InfoTask.new