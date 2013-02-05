module Cms
  module Attributes
    module GoogleAnalyticsTrackingId
      def google_analytics_tracking_id_attribute
        :google_analytics_tracking_id
      end

      def default_google_analytics_tracking_id
        ''
      ensure
        Cms::Errors::MissingAttribute.notify(self, __FILE__)
      end

      def tracking_id
        self[google_analytics_tracking_id_attribute] || default_google_analytics_tracking_id
      end
    end
  end
end