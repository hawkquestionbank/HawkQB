class AddCopiedFromQuestionIdToQuestion < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :copied_from_id, :integer
  end
end
