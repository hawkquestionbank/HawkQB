class CreateAttempts < ActiveRecord::Migration[5.2]
  def change
    create_table :attempts do |t|
      t.text :txt
      t.boolean :finished
      t.references :questions, index: true, foreign_key: true
      t.references :users, index: true, foreign_key: true
      t.references :answers, index: true, foreign_key: true

      t.timestamps
    end
  end
end
