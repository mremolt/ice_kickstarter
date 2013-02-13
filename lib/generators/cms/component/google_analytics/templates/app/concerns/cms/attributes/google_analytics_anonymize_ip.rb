module Cms
  module Attributes
    module GoogleAnalyticsAnonymizeIp
      def google_analytics_anonymize_ip_attribute
        :google_analytics_anonymize_ip
      end

      def default_google_analytics_anonymize_ip
        ''
      ensure
        Cms::Errors::MissingAttribute.notify(self, __FILE__)
      end

      def google_analytics_anonymize_ip
        self[google_analytics_anonymize_ip_attribute] || default_google_analytics_anonymize_ip
      end

      def anonymize_ip?
        google_analytics_anonymize_ip == 'Yes'
      end
    end
  end
end