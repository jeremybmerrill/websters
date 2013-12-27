class CreateDataDictionaryFields < ActiveRecord::Migration
  def change
    create_table :data_dictionary_fields do |t|
      # t.string :col_name
      # t.string :attribute_name
      # t.text :definition
      # t.string :display_name
      # t.string :datatype
      # t.string :source_basename
      <% Websters.fields_fields.each do |field_name, field_type| %>
        t.<%= field_type %> <%= field_name.downcase.to_sym %>

      <% end %>
      t.timestamps
    end
  end
end
