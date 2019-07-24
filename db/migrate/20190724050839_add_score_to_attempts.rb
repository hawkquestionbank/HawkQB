class AddScoreToAttempts < ActiveRecord::Migration[5.2]
  def change
    add_column :attempts, :score, :decimal
  end
end
