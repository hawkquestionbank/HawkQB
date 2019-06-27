class Question < ActiveRecord::Base

  # We will need a way to know which question types
  # will subclass the Question model
  def self.types
    %w(multiple_choice multiple_select fill_in_the_blank)
  end
end
