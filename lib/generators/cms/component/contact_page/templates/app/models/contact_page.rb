class ContactPage < Obj
  include Cms::Attributes::CrmActivityType
  include Cms::Attributes::ShowInNavigation
  include Cms::Attributes::RedirectAfterSubmitLink
  include Page
end