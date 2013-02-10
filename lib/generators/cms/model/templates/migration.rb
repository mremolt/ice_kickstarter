class Create<%= class_name %> < ::RailsConnector::Migration
  def up
    create_obj_class(
      name: '<%= class_name %>',
      type: '<%= type %>',
      title: '<%= title %>',
      attributes: <%= attributes.inspect %>
    )
  end
end