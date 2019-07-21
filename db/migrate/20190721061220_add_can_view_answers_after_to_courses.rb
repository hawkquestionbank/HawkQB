class AddCanViewAnswersAfterToCourses < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :can_view_answers_after, :datetime
  end
end
