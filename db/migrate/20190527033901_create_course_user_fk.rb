class CreateCourseUserFk < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :creator_user_id, :integer, index: true
    add_foreign_key :courses, :users, column: :creator_user_id
  end
end
