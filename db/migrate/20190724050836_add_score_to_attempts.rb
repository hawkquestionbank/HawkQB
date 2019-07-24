class AddScoreToAttempts < ActiveRecord::Migration[5.2]
  def change
    def change
      add_column :attempts, :score, :float
    end
  end
end
