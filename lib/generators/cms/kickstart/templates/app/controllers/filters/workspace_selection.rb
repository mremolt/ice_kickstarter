module Filters
  class WorkspaceSelection < Base
    class << self
      def filter(controller)
        super(controller)

        if switchable?
          switch_workspace
        end
      end

      private

      def switchable?
        workspace_param.present? && !live_environment?
      end

      def workspace_param
        params['ws']
      end

      def live_environment?
        EnvironmentDetection.live_environment?
      end

      def switch_workspace
        workspace = find_workspace_by_title(workspace_param)

        if workspace
          target = path(workspace)

          controller.redirect_to(target)
        end
      end

      def find_workspace_by_title(title)
        workspaces.detect do |workspace|
          workspace['title'] == title
        end
      end

      def workspaces
        ::RailsConnector::CmsRestApi.get('workspaces')['results']
      end

      def path(workspace)
        "#{request.path}?_rc-ws=#{workspace['id']}"
      end
    end
  end
end