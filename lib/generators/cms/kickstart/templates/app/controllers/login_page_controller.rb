class LoginPageController < CmsController
  include RailsConnector::Crm::Localizable

  def index
    @user_presenter = UserPresenter.new(params[:user_presenter])

    if request.post? && @user_presenter.valid?
      login
    elsif request.delete?
      logout
    end
  end

  private

  def login
    self.current_user = @user_presenter.authenticate

    if current_user.logged_in?
      target = params[:return_to] || cms_path(@obj.redirect_after_login)

      redirect_to(target, :notice => t(:'flash.login.success'))
    end
  end

  def logout
    discard_user

    target = cms_path(@obj.redirect_after_logout)

    redirect_to(target, :notice => t(:'flash.logout.success'))
  end
end