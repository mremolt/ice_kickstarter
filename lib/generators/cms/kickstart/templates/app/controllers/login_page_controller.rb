class LoginPageController < CmsController
  include RailsConnector::Crm::Localizable

  def index
    if request.post?
      login
    elsif request.delete?
      logout
    end
  end

  private

  def login
    params[:user] ||= {}

    user = Infopark::Crm::Contact.authenticate(params[:user][:login], params[:user][:password])
    cache_current_user(user)

    target = params[:return_to].presence || cms_path(@obj.homepage)

    redirect_to(target, :notice => t('login_page.login.notice'))
  rescue Infopark::Crm::Errors::AuthenticationFailed, ActiveResource::UnauthorizedAccess
    flash.now[:alert] = t('login_page.login.alert')
  end

  def logout
    discard_current_user

    redirect_to({ :action => 'index' }, :notice => t('login_page.logout.notice'))
  end
end