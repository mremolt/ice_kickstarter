class UserPresenter
  include ActiveAttr::BasicModel
  include ActiveAttr::MassAssignment

  attr_accessor :login
  attr_accessor :password

  validates :login, :presence => true
  validates :password, :presence => true

  def authenticate
    CrmAuthenticationService.new(login, password).authenticate
  rescue Infopark::Crm::Errors::AuthenticationFailed, ActiveResource::ResourceInvalid
    errors.add(:base, I18n.t(:'errors.messages.authentication_failed'))

    nil
  end
end