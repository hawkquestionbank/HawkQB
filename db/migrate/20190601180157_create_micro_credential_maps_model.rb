class CreateMicroCredentialMapsModel < ActiveRecord::Migration[5.2]
  def change
    create_table :micro_credential_maps_models do |t|
    t.belongs_to :course, index: true
    t.belongs_to :micro_credential, index: true
    end
  end
end
