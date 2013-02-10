class LoginPresenter
  include ActiveAttr::BasicModel
  include ActiveAttr::MassAssignment

  attr_accessor :login
  attr_accessor :password

  validates :login, :presence => true
  validates :password, :presence => true

  def authenticate
    Rails.configuration.user_manager.authenticate(login, password)
  rescue UserManager::AuthenticationFailed
    errors.add(:base, I18n.t(:'simple_form.error_notification.login_presenter'))

    nil
  end
end