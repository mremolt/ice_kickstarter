class User
  include ActiveAttr::Attributes
  include ActiveAttr::MassAssignment
  include ActiveAttr::AttributeDefaults

  attribute :id
  attribute :login
  attribute :role_names, :default => []

  def email
    @email ||= crm_contact.try(:email)
  end

  def logged_in?
    true
  end

  def admin?
    role_names.include?('cmsadmin')
  end

  def cache_attributes
    attributes.slice('id', 'login', 'role_names')
  end

  private

  def crm_contact
    @crm_contact ||= Infopark::Crm::Contact.find(id)
  end
end