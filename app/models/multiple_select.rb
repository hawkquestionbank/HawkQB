class MultipleSelect < Question
  scope :multiple_selects, -> { where(type: 'MultipleSelect') }
end