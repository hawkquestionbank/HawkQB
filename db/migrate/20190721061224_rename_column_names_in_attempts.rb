class RenameColumnNamesInAttempts < ActiveRecord::Migration[5.2]
  def change
    rename_column :attempts, :questions_id, :question_id
    rename_column :attempts, :answers_id, :answer_id
    rename_column :attempts, :users_id, :user_id
  end
end
