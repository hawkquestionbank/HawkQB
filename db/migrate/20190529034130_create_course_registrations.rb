class CreateCourseRegistrations < ActiveRecord::Migration[5.2]
  def change
    create_table :course_registrations do |t|
      t.reference :user
      t.reference :course

      t.timestamps
    end
  end
end
