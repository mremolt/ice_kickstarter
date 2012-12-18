module Cms
  module Generators
    module Component
      class AmazonSesGenerator < ::Rails::Generators::Base
        source_root File.expand_path('../templates', __FILE__)

        def create_initializer_file
          template 'amazon_ses.rb', File.join('config/initializers', 'amazon_ses.rb')
        end

        def set_delivery_method
          data = []

          data << '# Specifies the delivery method that your server uses for sending emails'
          data << '  config.action_mailer.delivery_method = :smtp'
          data << ''

          data = data.join("\n")

          environment(data, :env => :production)
        end

        def raise_delivery_errors
          data = []

          data << '# Enable delivery errors, bad email addresses will raise an error'
          data << '  config.action_mailer.raise_delivery_errors = true'
          data << ''

          data = data.join("\n")

          environment(data, :env => :production)
        end

        def set_default_url_options
          data = []

          data << '# Specifies the default url options used in link helpers of email templates'
          data << '  config.action_mailer.default_url_options = {'
          data << "    :host => 'localhost',"
          data << '    :port => 3000,'
          data << '  }'
          data << ''

          data = data.join("\n")

          environment(data, :env => :test)
        end
      end
    end
  end
end