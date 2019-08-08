module AttemptsHelper
  def show_take_link (personal_attempt_history, question, closed, course)
    if closed
      false
    else
      if personal_attempt_history.key?(question.id)   # if the user has taken this question b4
        if personal_attempt_history[question.id][:score] == 1  # if there is a correct attempt
          if course.in_exam_now?
            true  # in exam --> true
          else
            false   # not in exam -->false
          end
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
