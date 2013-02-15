class Create<%= class_name %>Attribute < ::RailsConnector::Migration
  def up
    create_attribute(
      name: '<%= file_name %>',
      type: '<%= type %>',
      title: '<%= title %>',
      <%- if max_size > 0 -%>
      max_size: <%= max_size %>,
      <%- end -%>
      <%- if min_size > 0 -%>
      min_size: <%= min_size %>
      <%- end -%>
    )
  end
end