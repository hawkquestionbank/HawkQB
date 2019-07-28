class AddIsAExamToCourse < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :is_an_exam, :boolean, default: false
  end
end
