RailsConnector::Configuration.instance_name = 'default'

RailsConnector::Configuration.choose_homepage do |env|
  Homepage.homepage_for_hostname(Rack::Request.new(env).host)
end