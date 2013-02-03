class ContactPagePresenter
  include ActiveAttr::Model

  attribute :email
  attribute :subject
  attribute :message

  validates :subject, :presence => true
  validates :email, :presence => true
  validates :email, :email => { :message => I18n.t('activemodel.errors.messages.invalid_email') }

  def initialize(user, attributes)
    prefill!(attributes, user)

    super(attributes)
  end

  private

  def prefill!(attributes, user)
    attributes.reverse_merge!({
      :email => user.email,
    })
  end
end