class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :handle, null: false
      t.integer :age
      t.integer :gender, null: false
      t.string :email, null: false
      t.timestamps
    end
  end
end
