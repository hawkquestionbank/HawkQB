class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.text :txt
      t.boolean :is_correct, default: false
    end
  end
end
