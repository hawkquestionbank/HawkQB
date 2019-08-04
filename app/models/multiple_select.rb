class MultipleSelect < Question
  scope :multiple_selects, -> { where(type: 'MultipleSelect') }

  def valid_attempt? attempt
    # for MultipleSelect attempt, we have to use @attempt.answer_hash.
    # It is guaranteed that the key "answer_ids" is in answer_hash,
    # we need to check if there are any answer id(s) there.
    attempt.answer_hash["answer_ids"].length != 0
  end

  def correct_answers
    # return all the correct answers of this question
    self.answers.where(:is_correct => 1)
  end

  def grade attempt
    # assign 1 (correct) or (0) incorrect to attempt.score
    # sanple attempt object:
    # <Attempt id: nil, txt: nil, question_id: 46, user_id: 3, answer_id: 87, created_at: "2019-07-26 12:39:03", updated_at: nil, answer_hash: {}, score: nil>
    # (please not that, the attempt object is not in DB yet)
    correct_answer_ids = self.correct_answers.pluck(:id)
    user_selected_answer_ids = attempt.answer_hash["answer_ids"]

    if correct_answer_ids.size ==0 or user_selected_answer_ids.size ==0
      false

    elsif correct_answer_ids.size == user_selected_answer_ids.size and (correct_answer_ids.map(&:to_s) & user_selected_answer_ids).size == correct_answer_ids.size
      attempt.score = 1
      true
    else
      attempt.score = 0
      true
    end
  end
end