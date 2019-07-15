class AddForeignKeysToQuestionMicroCredentials < ActiveRecord::Migration[5.2]
  def change
  	add_column :question_micro_credentials, :question_id, :integer, index: true
    add_foreign_key :question_micro_credentials, :questions, column: :question_id
    add_column :question_micro_credentials, :micro_credential_id, :integer, index: true
    add_foreign_key :question_micro_credentials, :micro_credentials, column: :micro_credential_id
  end
end
