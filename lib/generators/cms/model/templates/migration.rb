class Create<%= class_name %> < ::RailsConnector::Migrations::Migration
  def up
    create_obj_class(:name => '<%= class_name %>', :type => 'publication', :title => '<%= human_name %>', :attributes => <%= attributes %>)
  end
end