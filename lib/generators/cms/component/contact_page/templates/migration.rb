# encoding = utf-8

class CreateContactPage < ::RailsConnector::Migration
  def homepage_path
    '<%= homepage_path %>'
  end

  def path
    "#{homepage_path}/_configuration/contact"
  end

  def contact_page_attribute
    'contact_page_link'
  end

  def class_name
    '<%= class_name %>'
  end

  def crm_activity_type_attribute
    '<%= crm_activity_type_attribute_name %>'
  end

  def redirect_after_submit_attribute
    '<%= redirect_after_submit_attribute_name %>'
  end

  def activity_type
    '<%= activity_type %>'
  end

  def up
    create_attribute(
      name: crm_activity_type_attribute,
      title: 'CRM Activity Type',
      type: :string
    )

    create_attribute(
      name: redirect_after_submit_attribute,
      title: 'Redirect After Submit Page',
      type: :linklist,
      max_size: 1
    )

    create_obj_class(
      name: class_name,
      type: 'publication',
      title: 'Page: Contact',
      attributes: [
        crm_activity_type_attribute,
        redirect_after_submit_attribute,
        'show_in_navigation',
      ]
    )

    create_obj(
      _path: path,
      _obj_class: class_name,
      title: 'Kontaktformular',
      body: '<p>Bitte füllen Sie das unten stehende Formular aus, um mit uns Kontakt aufzunehmen.
        Wir melden uns danach umgehend bei Ihnen bezüglich Ihres Anliegens.</p>',
      crm_activity_type_attribute => activity_type,
      show_in_navigation: 'Yes',
      redirect_after_submit_attribute => [{ url: homepage_path }]
    )

    create_attribute(
      name: contact_page_attribute,
      title: 'Contact Page',
      type: :linklist,
      max_size: 1
    )

    attributes = get_obj_class('Homepage')['attributes'] << contact_page_attribute
    update_obj_class('Homepage', attributes: attributes)

    update_obj(
      Obj.find_by_path(homepage_path).id,
      contact_page_attribute => [{ url: path }]
    )

    setup_crm
  end

  def setup_crm
    Infopark::Crm::CustomType.find(activity_type)
  rescue ActiveResource::ResourceNotFound
    custom_attributes = [
      { name: 'email', title: 'E-Mail-Adresse', type: 'string' },
      { name: 'message', title: 'Nachricht', type: 'text', max_length: 1000 }
    ]

    Infopark::Crm::CustomType.create(
      kind: 'Activity',
      name: activity_type,
      states: ['open', 'closed'],
      icon_css_class: 'omc_activity_23',
      custom_attributes: custom_attributes
    )
  end
end
