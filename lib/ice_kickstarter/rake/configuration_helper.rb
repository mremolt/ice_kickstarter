require 'helpful_configuration'

module IceKickstarter
  module Rake
    class ConfigurationHelper
      attr_reader :file
      attr_reader :configuration
      attr_reader :target

      def initialize(file, type, target)
        @file = file
        @configuration = send("#{type}_configuration")
        @target = target
      end

      def write
        content = configuration.to_yaml

        File.open(target, 'w') do |file|
          file.write(content)
        end
      end

      def cms_configuration
        {
          'cms_api' => {
            'url' => 'https://admin.saas.infopark.net/cms',
            'login' => 'root',
            'api_key' => choose_correct_value(local_configuration['integration_test_cms_api_key']),
            'http_host' => choose_correct_value(local_configuration['integration_test_tenant_name']),
          },
          'content_service' => {
            'url' => 'https://contents.infopark.net',
            'login' => choose_correct_value(local_configuration['integration_test_tenant_name']),
            'api_key' => choose_correct_value(local_configuration['integration_test_content_read_api_key']),
          }
        }
      end

      def crm_configuration
        {
          'crm' => {
            'url' => 'https://admin.saas.infopark.net/crm',
            'login' => 'root',
            'api_key' => choose_correct_value(local_configuration['integration_test_crm_api_key']),
            'http_host' => choose_correct_value(local_configuration['integration_test_tenant_name']),
          }
        }
      end

      def local_configuration
        @local_configuration ||= HelpfulConfiguration.new(content, file).tap do |config|
          config.explain(
            'integration_test_tenant_name',
            'Name of the tenant for integration test'
          )
          config.explain(
            'integration_test_cms_api_key',
            'CMS api_key for integration test'
          )
          config.explain(
            'integration_test_content_read_api_key',
            'Content Read api_key for integration test'
          )
          config.explain(
            'integration_test_crm_api_key',
            'CRM api_key for integration test'
          )
        end
      end

      def content
        content = File.read(file)

        YAML.load(content)
      end

      def choose_correct_value(value)
        if value.instance_of?(Hash)
          value[server_name]
        else
          value
        end
      end

      def server_name
        %x'hostname'.strip
      end
    end
  end
end