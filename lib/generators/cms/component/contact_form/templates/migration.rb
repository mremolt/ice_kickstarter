class CreateContactPage < ::RailsConnector::Migration
  def homepage_path
    '/website/de'
  end

  def configuration_path
    "#{homepage_path}/_configuration"
  end

  def contact_page_attribute
    'contact_page_link'
  end

  def path
    "#{configuration_path}/contact"
  end

  def class_name
    '<%= class_name %>'
  end

  def crm_activity_type_attribute
    '<%= crm_activity_type_attribute_name %>'
  end

  def up
    create_attribute(
      :name => crm_activity_type_attribute,
      :title => 'CRM Activity Type',
      :type => :string
    )

    create_obj_class(
      :name => class_name,
      :type => 'publication',
      :title => 'Page: Contact',
      :attributes => [
        'crm_activity_type',
        'show_in_navigation',
      ]
    )

    create_obj(
      :_path => path,
      :_obj_class => class_name,
      :title => 'Kontaktformular',
      :body => '<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
        tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
        quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
        consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
        cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
        proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>',
      crm_activity_type_attribute => 'contact-form',
      :show_in_navigation => 'Yes'
    )

    create_attribute(
      :name => contact_page_attribute,
      :title => 'Contact Page',
      :type => :linklist,
      :max_size => 1
    )

    attributes = get_obj_class('Homepage')['attributes'] << contact_page_attribute
    update_obj_class('Homepage', :attributes => attributes)

    update_obj(
      Obj.find_by_path(homepage_path).id,
      contact_page_attribute => [{ :url => path }]
    )
  end
end