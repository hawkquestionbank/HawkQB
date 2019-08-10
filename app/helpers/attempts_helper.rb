module AttemptsHelper
  def show_take_link (personal_attempt_history, question, closed, course)
    if closed
      false
    elsif course.in_exam_now? or (course.can_view_answers_after and DateTime.now<course.close_to_attempts)
      if not course.max_attempts.nil? and not personal_attempt_history.key?(question.id)
        # when the max_attempts is not nil, but the user has not taken this question -->true
        true
      elsif not course.max_attempts.nil? and personal_attempt_history[question.id][:num_attempts] < course.max_attempts
        # when the max_attempts is not nil, the user has take this question, but there are more allowed attempts -->true
        true
      elsif @course.max_attempts.nil?
        # if there is no limit on # of attempts -->true
        true
      else
        false
      end
    else
      if personal_attempt_history.key?(question.id)   # if the user has taken this question b4
        if personal_attempt_history[question.id][:score] == 1  # if there is a correct attempt -->false
          false
        elsif not course.max_attempts.nil? and personal_attempt_history[question.id][:num_attempts] < course.max_attempts
          # if there is no correct attempt, check if there is more attempt allowed  --> true
          true
        elsif @course.max_attempts.nil?
          # if there is no limit on # of attempts -->true
          true
        else
          # otherwise
          false
        end
      else  # if the user has NOT taken this question b4, and the course is not closed yet --> true
        true
      end
    end
  end

  def show_correct_wrong_icon(personal_attempt_history, question)
    if personal_attempt_history.key?(question.id)   # if the user has taken this question b4
      if personal_attempt_history[question.id][:score] == 1  # if there is a correct attempt --> false
        :correct
      else
        :wrong
      end
    else
      false
    end
  end

end
