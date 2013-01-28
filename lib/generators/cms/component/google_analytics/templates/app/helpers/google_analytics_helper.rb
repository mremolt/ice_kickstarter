module GoogleAnalyticsHelper
	def render_google_analytics(homepage)
		obj = homepage.google_analytics.first.destination_object

		render(
			'layouts/google_analytics/google_analytics_snippet',
			:tracking_id => obj.tracking_id,
			:anonymize_ip => obj.anonymize_ip?
		)
	end
end