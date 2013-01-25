module IceKickstarter
  module Rake
    module CredentialHelper
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
  end
end