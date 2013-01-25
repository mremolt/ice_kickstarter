class CreateStructure < ::RailsConnector::Migration
  def up
    create_obj(:_path => '/website/<%= file_name %>', :_obj_class => 'Homepage', :title => '<%= title %>', :locale => '<%= file_name %>')
  end
end