class <%= class_name %> < Obj
  <%- attributes.each do |attribute| -%>
  <%= "include Cms::Attributes::#{attribute.classify}" %>
  <%- end -%>
  include Page
end