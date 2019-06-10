class MicroCredential < ActiveRecord::Base
	has_many :micro_credential_maps
	has_many :courses, through: :micro_credential_maps

  validates_length_of :identifier, :maximum => 20
end