class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.references :shout
      t.references :user
      t.text :body

      t.timestamps
    end
    add_foreign_key :comments, :shouts, on_delete: :cascade
    add_foreign_key :comments, :users, on_delete: :cascade
  end
end
