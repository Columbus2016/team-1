class CreateDiagnoses < ActiveRecord::Migration[5.0]
  def change
    create_table :diagnoses do |t|
      t.belongs_to :user, index: true
      t.belongs_to :cancer, index: true
      t.datetime :diagnosed_at
      t.timestamps
    end
  end
end
