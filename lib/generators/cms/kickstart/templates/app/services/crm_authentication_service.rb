class CrmAuthenticationService
  attr_reader :login
  attr_reader :password

  def initialize(login, password)
    @login = login
    @password = password
  end

  def authenticate
    contact = Infopark::Crm::Contact.authenticate(login, password)

    create_user(contact)
  end

  private

  def create_user(contact)
    User.new({
      :id => contact.id,
      :login => contact.login,
      :role_names => contact.role_names,
    })
  end
end