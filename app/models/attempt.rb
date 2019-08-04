class Attempt < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  belongs_to :answer, optional: true
end

