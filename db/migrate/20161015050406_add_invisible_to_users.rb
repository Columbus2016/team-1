class AddInvisibleToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :invisible, :boolean,
      null: false, default: false
  end
end
