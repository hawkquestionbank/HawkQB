class MicroCredential < ActiveRecord::Base
	has_many :micro_credential_maps
	has_many :courses, through: :micro_credential_maps

	belongs_to :creator, class_name: 'User', foreign_key: 'creator_user_id'

	validates_presence_of :title, :message => "can't be empty"
	validates_presence_of :identifier, :message => "can't be empty"
  validates_length_of :identifier, :maximum => 20

end