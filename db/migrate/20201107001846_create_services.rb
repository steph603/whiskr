class CreateServices < ActiveRecord::Migration[6.0]
  def change
    create_table :services do |t|
      t.string :name
      t.text :description
      t.decimal :price
      t.integer :user_id

      t.timestamps
    end
    add_index :services, :user_id
  end
end
