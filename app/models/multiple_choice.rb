class MultipleChoice < Question
  scope :multiple_choices, -> { where(type: 'MultipleChoice') }


  def valid_attempt? attempt
    # validate an attempt prepared by attempt_controller/create
    # MultipleChoice: there is always a selected answer from UI
    # So simply return true
    true
  end

  def correct_answer
    self.answers.where(:is_correct => 1).first
  end

  def grade attempt
    # assign 1 (correct) or (0) incorrect to attempt.score
    # sanple attempt object:
    # <Attempt id: nil, txt: nil, question_id: 46, user_id: 3, answer_id: 87, created_at: "2019-07-26 12:39:03", updated_at: nil, answer_hash: {}, score: nil>
    # (please not that, the attempt object is not in DB yet)
    if attempt.answer_id.nil?
      false
    elsif attempt.answer_id == self.correct_answer.id
      attempt.score = 1
      true
    else
      attempt.score = 0
      true
    end

  end
end
