module IceKickstarter
  class DashboardsController < ApplicationController
    layout 'ice_kickstarter/dashboard'

    before_filter :require_local!, :only => [:info]

    def show
      @meta_stats = Dashboard::MetaStats.new
    end

    def help
      @gems = Dashboard::Gem.all
    end

    def people
      @editors = Dashboard::Editor.all
      @developers = Dashboard::Developer.all
    end

    def content
      @cms_stats = Dashboard::CmsStats.new
      @crm_stats = Dashboard::CrmStats.new
    end

    private

    def require_local!
      unless local_request?
        render(
          :text => '<p>For security purposes, this information is only available to local requests.</p>',
          :status => :forbidden
        )
      end
    end

    def local_request?
      Rails.configuration.consider_all_requests_local || request.local?
    end
  end
end