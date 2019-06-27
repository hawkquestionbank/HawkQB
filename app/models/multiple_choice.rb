class MultipleChoice < Question
  scope :multiple_choices, -> { where(type: 'MultipleChoice') }
end
