class AddCourseTokenToCourses < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :token, :string
  end
end
