class MicroCredential < ActiveRecord::Base
	has_many :micro_credential_maps
	has_many :courses, through: :micro_credential_maps
end