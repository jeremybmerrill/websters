class Field < ActiveRecord::Base
  attr_accessible <%= Websters.fields_fields.keys.map{|name| name.downcase.to_sym } %>
end
