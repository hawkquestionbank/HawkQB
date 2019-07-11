class MicroCredential < ActiveRecord::Base
	has_many :micro_credential_maps
	has_many :courses, through: :micro_credential_maps

	belongs_to :creator, class_name: 'User', foreign_key: 'creator_user_id'

	validates_presence_of :title, :message => "can't be empty"
	validates_presence_of :identifier, :message => "can't be empty"
  validates_length_of :identifier, :maximum => 20

  def self.available_micro_credentials user
		if user.role == :student
			[]
		else
			self_created_micro_credentials = user.own_micro_credentials
			self_created_micro_credential_ids = self_created_micro_credentials.map(&:id)

			used_micro_credential_ids = MicroCredentialMap.distinct.pluck(:micro_credential_id)

			# find the ids in self_created_micro_credential_ids but not in used_micro_credential_ids
			MicroCredential.find(self_created_micro_credential_ids - used_micro_credential_ids)
		end
	end

end