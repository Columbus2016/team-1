class AddStageToDiagnoses < ActiveRecord::Migration[5.0]
  def change
    add_column :diagnoses, :stage, :integer,
      null: false, default: 1
  end
end
