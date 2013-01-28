module GoogleAnalyticsHelper
	def google_analytics_tracking_id(obj)
		homepage = obj.homepage
		tracking_id = nil

		if homepage
			google_analytics_obj = homepage.google_analytics.first.destination_object
			tracking_id = google_analytics_obj.google_analytics_tracking_id if google_analytics_obj
		end

		tracking_id
	end

	def google_analytics_anonymize_ip?(obj)
		homepage = obj.homepage
		anonymize_ip = false

		if homepage
			google_analytics_obj = homepage.google_analytics.first.destination_object
			anonymize_ip = google_analytics_obj.google_analytics_anonymize_ip if google_analytics_obj
		end

		anonymize_ip == ('Yes')
	end
end