class AddBirthdateToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :birthdate, :datetime
    remove_column :users, :age
  end
end
