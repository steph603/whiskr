class AddNurseToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :is_nurse, :boolean, default: false
  end
end
