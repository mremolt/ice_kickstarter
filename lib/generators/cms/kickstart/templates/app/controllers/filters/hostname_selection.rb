module Filters
  class HostnameSelection < Base
    class << self
      def filter(controller)
        super(controller)

        if check_hostname? && switch_hostname?
          switch_hostname
        end
      end

      private

      def check_hostname?
        EnvironmentDetection.live_environment? && request.get?
      end

      def switch_hostname?
        Homepage.for_hostname(current_hostname) != current_homepage
      end

      def current_hostname
        request.host
      end

      def current_homepage
        @current_homepage ||= current_obj.homepage
      end

      def current_obj
        @current_obj ||= controller.instance_variable_get(:@obj)
      end

      def switch_hostname
        controller.redirect_to(desired_url)
      end

      def desired_url
        cms_url(current_obj, host: desired_hostname)
      end

      def desired_hostname
        current_homepage.desired_hostname
      end
    end
  end
end