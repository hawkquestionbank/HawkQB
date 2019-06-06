class MicroCredentialMap < ActiveRecord::Base
  belongs_to :course
  belongs_to :micro_credential
end