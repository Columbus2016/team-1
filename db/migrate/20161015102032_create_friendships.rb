class CreateFriendships < ActiveRecord::Migration[5.0]
  def change
    create_table :friendships do |t|
      t.integer :sender_id, null: false
      t.integer :reciever_id, null: false
      t.timestamps
    end
  end
end
