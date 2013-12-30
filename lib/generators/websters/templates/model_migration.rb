class Create<%= @name %> < ActiveRecord::Migration
  def change
    create_table :<%= @name.underscore.pluralize %> do |t|
      <% @fields.each do |field| %>
        t.<%= field[:datatype] -%> :<%= field[:col_name] -%>
      <% end %>
      t.timestamps
    end
  end
end
