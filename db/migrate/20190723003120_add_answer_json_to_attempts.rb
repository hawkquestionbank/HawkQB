class AddAnswerJsonToAttempts < ActiveRecord::Migration[5.2]
  def change
    add_column :attempts, :answer_hash, :json, default: {}
  end
end
