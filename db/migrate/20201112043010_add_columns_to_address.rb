class AddColumnsToAddress < ActiveRecord::Migration[6.0]
  def change
    add_column :addresses, :street, :string, default: ""
    add_column :addresses, :suburb, :string, default: ""
    add_column :addresses, :state, :string, default: ""
  end
end
