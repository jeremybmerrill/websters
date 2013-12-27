class Field < ActiveRecord::Base
  attr_accessible :col_name, :attribute_name, :definition, :display_name, :datatype, :source_basename, 
end
