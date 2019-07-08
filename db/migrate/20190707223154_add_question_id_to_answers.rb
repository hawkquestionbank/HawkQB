class AddQuestionIdToAnswers < ActiveRecord::Migration[5.2]
  def change
    add_column :answers, :question_id, :integer, index: true
    add_foreign_key :answers, :questions, column: :question_id
  end
end
