module IceKickstarter
  class Engine < Rails::Engine
    isolate_namespace IceKickstarter

    config.generators do |generator|
      generator.test_framework :rspec, fixture: false
    end

    initializer('ice_kickstarter.configuration') do |app|
      app.config.ice_kickstarter = IceKickstarter::Configuration.new
    end
  end
end