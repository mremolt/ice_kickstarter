class ProfilePagePresenter
  include ActiveAttr::Model

  attr_reader :user

  attribute :user_id
  attribute :account_id
  attribute :country
  attribute :email
  attribute :extended_address
  attribute :fax
  attribute :first_name
  attribute :gender
  attribute :job_title
  attribute :language
  attribute :last_name
  attribute :locality
  attribute :login
  attribute :mobile_phone
  attribute :name_prefix
  attribute :org_name_address
  attribute :org_unit_address
  attribute :phone
  attribute :postalcode
  attribute :region
  attribute :role_names
  attribute :street_address
  attribute :tags
  attribute :want_email
  attribute :want_geo_location
  attribute :want_phonecall
  attribute :want_snailmail

  validates :last_name, :presence => true
  validates :email, :presence => true
  validates :email, :email => { :message => I18n.t('activemodel.errors.messages.invalid_email') }

  def initialize(user, attributes = {})
    @user = user

    attributes ||= {}

    prefill!(user, attributes)
    
    super(attributes)
  end

  def save
    if valid?
      save_crm_contact
    end
  end

private

  def save_crm_contact
    attributes.each do |key, value|
      if user.crm_attributes.include?(key)
        user.crm_attributes[key] = value
      end
    end

    user.crm_contact.save
  end

  def prefill!(user, attributes)
    attributes['user_id'] = user.id
    attributes.reverse_merge!(user.crm_attributes)
  end
end