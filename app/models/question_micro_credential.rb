class QuestionMicroCredential < ActiveRecord::Base
	belongs_to :micro_credential
	belongs_to :question
end
