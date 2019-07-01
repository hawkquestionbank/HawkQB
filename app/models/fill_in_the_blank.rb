class FillInTheBlank < Question
  scope :fill_in_the_blanks, -> { where(type: 'FillInTheBlank') }
end