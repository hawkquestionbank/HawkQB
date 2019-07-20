class Question < ActiveRecord::Base
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_user_id'
  has_many :answers
  has_many :question_micro_credentials
  has_many :micro_credentials, through: :question_micro_credentials
  belongs_to :course, optional: true
  has_many :attempts

  # We will need a way to know which question types
  # will subclass the Question model
  def self.types
    %w(multiple_choice multiple_select fill_in_the_blank)
  end
end
