class ChangeMicroCredentialMapsTableName < ActiveRecord::Migration[5.2]
  def change
    rename_table :micro_credential_maps_models, :micro_credential_maps
  end
end
