class Create<%= class_name %>Attribute < ::RailsConnector::Migrations::Migration
  def up
    create_attribute(:name => '<%= file_name %>', :type => '<%= type %>')
  end
end