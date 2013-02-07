class ProfilePageController < CmsController
  include RailsConnector::Crm::Localizable

  before_filter :authenticate!

  def index
    @profile_page_presenter = ProfilePagePresenter.new(current_user, params[:profile_page_presenter])

    if request.post? && @profile_page_presenter.save
      flash.now[:notice] = I18n.t('flash.profile_page.success')
    end
  end
end