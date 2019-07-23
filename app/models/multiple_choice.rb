class MultipleChoice < Question
  scope :multiple_choices, -> { where(type: 'MultipleChoice') }

  def valid_attempt? attempt
    # validate an attempt prepared by attempt_controller/create
    # MultipleChoice: there is always a selected answer from UI
    # So simply return true
    true
  end
end
