class AddDefaultNumberOfChoicesToCourses < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :default_number_of_choices, :integer, default: 4
  end
end
