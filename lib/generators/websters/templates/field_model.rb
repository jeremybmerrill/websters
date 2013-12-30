class DataDictionaryField < ActiveRecord::Base
  attr_accessible <%= @fields_fields.keys.map{|name| ":" + name.to_s.downcase }.join(", ") %>
end
