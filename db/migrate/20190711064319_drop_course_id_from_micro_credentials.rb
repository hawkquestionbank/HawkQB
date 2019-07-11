class DropCourseIdFromMicroCredentials < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :micro_credentials, column: :course_id
    remove_column :micro_credentials, :course_id
  end
end
