class AddClosedToAttempsToCourses < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :close_to_attempts, :datetime
  end
end
