class User
  include ActiveModel::Dirty
  include ActiveAttr::Attributes
  include ActiveAttr::MassAssignment

  attribute :id
  attribute :login
  attribute :role_names
  attribute :country
  attribute :email
  attribute :extended_address
  attribute :fax
  attribute :gender
  attribute :first_name
  attribute :job_title
  attribute :language
  attribute :last_name
  attribute :mobile_phone
  attribute :name_prefix
  attribute :company
  attribute :department
  attribute :phone
  attribute :postalcode
  attribute :region
  attribute :city
  attribute :street_address
  attribute :want_email
  attribute :want_geo_location
  attribute :want_phonecall
  attribute :want_snailmail

  (attribute_names - ['id']).each do |name|
    define_method(name) do
      if super.nil?
        lazy_load(name)
      else
        super
      end
    end

    define_method("#{name}=") do |value|
      changed_attributes[name] = value

      super
    end
  end

  def initialize(attributes = {})
    attributes.stringify_keys!

    if attributes['id'].blank?
      raise ArgumentError.new('Please provide an user ID.')
    end

    super(attributes)
  end

  def cache_attributes
    attributes.slice('id', 'login', 'role_names')
  end

  def save
    user_manager.save_user(self)

    @previously_changed = changes
    @changed_attributes.clear
  end

  def logged_in?
    true
  end

  def admin?
    user_manager.admin?(self)
  end

  private

  def user_manager
    Rails.configuration.user_manager
  end

  def lazy_load(attribute)
    return if @loaded

    @loaded = user_manager.update_user(self)

    read_attribute(attribute)
  end
end