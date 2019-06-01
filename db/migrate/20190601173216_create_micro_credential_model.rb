class CreateMicroCredentialModel < ActiveRecord::Migration[5.2]
  def change
    create_table :micro_credentials do |t|
      t.string :title
      t.text :description
    end
  end
end
