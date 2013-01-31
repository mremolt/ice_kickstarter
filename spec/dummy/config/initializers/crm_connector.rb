require 'infopark_crm_connector'

custom_cloud_config = YAML.load_file(Rails.root.join(*%w[config custom_cloud.yml]))

Infopark::Crm.configure do |config|
  config.url = custom_cloud_config['crm']['url']
  config.login = custom_cloud_config['crm']['login']
  config.api_key = custom_cloud_config['crm']['api_key']
  config.http_host = custom_cloud_config['crm']['http_host']
  # config.live_server_groups_callback = lambda { |contact|
  #   case contact.account.name
  #   when 'My Company'
  #     %w(internal)
  #   else
  #     []
  #   end
  # }
end

RailsConnector::Configuration.use_recaptcha_on_user_registration = false