module Filters
  # This class is a before filter used in controller to authorize the request.
  # If the request is authorized, nothing happens. If the request is not
  # authorized, the user is redirected to the login page and the +return_to+
  # parameter is set.
  #
  # Example:
  #
  # class ExampleController < ApplicationController
  #   before_filter Filters::Authorization
  # end
  class Authorization < Base
    class << self
      def filter(controller)
        super(controller)

        unless authorized?
          redirect_to_login_page
        end
      end

      private

      # Checks if the request is authorized to display the page. This method can
      # be customized to check for user roles, for example.
      def authorized?
        current_user.logged_in?
      end

      # The user is redirected to the login page and the return_to parameter is
      # set, so that the user returns to the originally requested page after
      # a successfull login.
      def redirect_to_login_page
        redirect_to(target, alert: I18n.t(:'flash.authorization_failed'))
      end

      def target
        controller.cms_path(login_page, return_to: return_to)
      end

      def return_to
        request.path
      end

      def login_page
        homepage.login_page
      end

      def homepage
        current_object.try(:homepage) || Obj.default_homepage
      end

      def current_object
        controller.instance_variable_get(:@obj)
      end
    end
  end
end