class AddHideToStudentsAfterToCourses < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :hide_from_students_after, :datetime
  end
end
