class CreateGoogleAnalytics < ::RailsConnector::Migrations::Migration
  def up
    create_attributes_and_obj_class
    create_objs
    deactivate_obj_class
    add_hompage_attribute
    connect_hompages_with_configuration
  end

  private

  def class_name
    'GoogleAnalytics'
  end

  def obj_path_for_homepage(homepage)
    "#{homepage.path}/_configuration/google_analytics"
  end

  def create_attributes_and_obj_class
    create_attribute(
      :name => 'google_analytics_tracking_id',
      :title => 'Tracking ID',
      :type => :string
    )

    create_attribute(
      :name => 'google_analytics_anonymize_ip',
      :title => 'Anonymize IP?',
      :type => :enum,
      :values => ['Yes', 'No']
    )

    params = {
      :name => class_name,
      :type => :publication,
      :title => 'Google Analytics',
      :attributes => [
        'google_analytics_tracking_id',
        'google_analytics_anonymize_ip',
      ],
      :preset_attributes => {
        'google_analytics_anonymize_ip' => '<%= anonymize_ip_default %>',
        'google_analytics_tracking_id' => '<%= tracking_id_default %>',
      },
    }

    create_obj_class(params)
  end

  def homepages
    @homepages ||= Obj.find_by_path('/website').toclist
  end

  def create_objs
    homepages.each do |homepage|
      create_obj(
        :_path => obj_path_for_homepage(homepage),
        :_obj_class => class_name,
        :title => 'Google Analytics'
      )
    end
  end

  def deactivate_obj_class
    update_obj_class(class_name, :is_active => false)
  end

  def add_hompage_attribute
    create_attribute(
      :name => attribute_name,
      :title => 'Google Analytics',
      :type => :linklist,
      :max_size => 1
    )

    obj_class_attributes = get_obj_class('Homepage')['attributes']
    obj_class_attributes << attribute_name
    update_obj_class('Homepage', :attributes => obj_class_attributes)
  end

  def attribute_name
    'google_analytics'
  end

  def connect_hompages_with_configuration
    homepages.each do |homepage|
      path = obj_path_for_homepage(homepage)
      obj = Obj.find_by_path(path)

      update_obj(homepage.id, :google_analytics => [{ :obj_id => obj.id }])
    end
  end
end