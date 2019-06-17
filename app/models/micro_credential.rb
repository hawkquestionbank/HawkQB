class MicroCredential < ActiveRecord::Base
	has_many :micro_credential_maps
	has_many :courses, through: :micro_credential_maps

	validates_presence_of :title, :message => "can't be empty"
	validates_presence_of :identifier, :message => "can't be empty"
  validates_length_of :identifier, :maximum => 20

  def creator
    User.find(self.creator_user_id)
  end
end