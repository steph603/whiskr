class DeleteColumns < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :street_addr
    change_column :users, :is_nurse, :boolean, null: false
    change_column :addresses, :street, :string, null: false
    change_column :addresses, :suburb, :string, null: false
    change_column :addresses, :state, :string, null: false
    change_column :services, :name, :string, null: false
    change_column :services, :description, :text, null: false
    change_column :services, :price, :decimal, null: false
    change_column :pets, :name, :string, null: false
    add_column :pets, :species, :string, null: false
  end
end
