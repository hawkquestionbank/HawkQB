class AddCourseIdToMicroCredentials < ActiveRecord::Migration[5.2]
  def change
    add_column :micro_credentials, :course_id, :integer, index: true
    add_foreign_key :micro_credentials, :courses, column: :course_id
  end
end
