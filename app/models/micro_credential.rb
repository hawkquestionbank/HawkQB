class MicroCredential < ActiveRecord::Base
	has_many :course, through: :micro_credential_maps
end