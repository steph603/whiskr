class DropTables < ActiveRecord::Migration[6.0]
  def change
    drop_table :address_tables
    drop_table :autocompletes
    drop_table :cities
  end
end
