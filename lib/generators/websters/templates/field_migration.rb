class CreateDataDictionaryField < ActiveRecord::Migration
  def change
    create_table :data_dictionary_fields do |t|
      <% @fields_fields.each do |field_name, field_type| %>
        t.<%= field_type -%> :<%= field_name.downcase -%>
      <% end %>
      t.timestamps
    end

    fields = <%= @fields %>

    fields.each do |field|
      DataDictionaryField.create({
        :col_name => field[:col_name],
        :attribute_name => field[:attribute_name],
        :definition => field[:definition],
        :display_name => field[:display_name],
        :datatype => field[:datatype],
        :source_model => field[:source_model],
      })
    end
  end
end
