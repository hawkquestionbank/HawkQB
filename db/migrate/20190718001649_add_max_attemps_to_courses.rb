class AddMaxAttempsToCourses < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :max_attemps, :integer, default: 2
  end
end
