class Create<%= class_name %>Attribute < ::RailsConnector::Migration
  def up
    params = {}

    params[:name] = '<%= file_name %>'
    params[:type] = '<%= type %>'
    params[:title] = '<%= title %>'
    params[:values] = values if values.present?
    params[:max_size] = max_size if max_size > 0
    params[:min_size] = min_size if min_size > 0

    create_attribute(params)
  end

  private

  def values
    <%= values %>
  end

  def min_size
    <%= min_size %>
  end

  def max_size
    <%= max_size %>
  end
end