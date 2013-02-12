class CreateProfilePage < ::RailsConnector::Migration
  def homepage_path
    '<%= homepage_path %>'
  end

  def path
    "#{homepage_path}/_configuration/profile"
  end

  def profile_page_attribute
    'profile_page_link'
  end

  def class_name
    '<%= class_name %>'
  end

  def up
    create_obj_class(
      :name => class_name,
      :type => 'publication',
      :title => 'Page: Profile',
      :attributes => [
        'show_in_navigation',
      ]
    )

    create_obj(
      :_path => path,
      :_obj_class => class_name,
      :title => 'Profil',
      :body => '<p>Hier koennen Sie Ihre persoenlichen Daten bearbeiten.</p>',
      :show_in_navigation => 'Yes'
    )

    create_attribute(
      :name => profile_page_attribute,
      :title => 'Profile Page',
      :type => :linklist,
      :max_size => 1
    )

    attributes = get_obj_class('Homepage')['attributes'] << profile_page_attribute
    update_obj_class('Homepage', :attributes => attributes)

    update_obj(
      Obj.find_by_path(homepage_path).id,
      profile_page_attribute => [{ :url => path }]
    )
  end
end