class RenamePostToShout < ActiveRecord::Migration[5.0]
  def change
    rename_table :posts, :shouts
  end
end
