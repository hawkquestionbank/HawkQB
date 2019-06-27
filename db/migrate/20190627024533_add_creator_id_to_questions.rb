class AddCreatorIdToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :creator_user_id, :integer, index: true
    add_foreign_key :questions, :users, column: :creator_user_id
  end
end
