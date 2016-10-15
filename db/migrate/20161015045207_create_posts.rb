class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.references :user
      t.text :body

      t.timestamps
    end

    add_foreign_key :posts, :users
  end
end
