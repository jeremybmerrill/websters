class <%= @name %> < ActiveRecord::Base
  attr_accessible <%= @fields.map{|field| ":" + field[:col_name] }.join(", ") %>

  def self.get_col_description(col_name)
    DataDictionaryField.where(:col_name => col_name).first.description
  end
  def self.get_col_info(col_name)
    attrs = Object.attribute_names.map(&:to_sym)
    ret = {}
    d = DataDictionaryField.where(:col_name => col_name)
    attrs.each do |attrib|
      ret[attrib] = d.send(attrib)
    end
  end
end