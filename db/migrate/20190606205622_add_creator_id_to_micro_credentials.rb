class AddCreatorIdToMicroCredentials < ActiveRecord::Migration[5.2]
  def change
    add_column :micro_credentials, :identifier, :string, :limit =>20
  end
end
