module Filters
  class Base
    class << self
      attr_reader :controller

      delegate :params, :session, :request, :logger, :current_user, :to => :controller

      def filter(controller)
        @controller = controller
      end
    end
  end
end