class AddLocationToUseres < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :location, :st_point,
      geographic: true, null: false
  end
end
