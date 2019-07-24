class DropFininshedFromAttempts < ActiveRecord::Migration[5.2]
  def change
    remove_column :attempts, :finished
  end
end
