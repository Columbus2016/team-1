class FixMispelling < ActiveRecord::Migration[5.0]
  def change
    rename_column :friendships, :reciever_id, :receiver_id
  end
end
