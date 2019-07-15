class AddCourseIdToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :course_id, :integer, index: true
    add_foreign_key :questions, :courses, column: :course_id
  end
end
