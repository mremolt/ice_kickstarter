class Create<%= class_name %>Attribute < ::RailsConnector::Migrations::Migration
  def up
    params = {}
    params[:name] = '<%= file_name %>'
    params[:type] = '<%= type %>'
    params[:values] = values if values?

    create_attribute(params)
  end

  private

  def values
    <%= values %>
  end

  def values?
    values.present?
  end
end