module IceKickstarter
  class Engine < Rails::Engine
    config.generators do |generator|
      generator.test_framework :rspec, :fixture => true
      generator.assets false
      generator.helper false
    end
  end
end