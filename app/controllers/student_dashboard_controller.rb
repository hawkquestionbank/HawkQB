class StudentDashboardController < ApplicationController
  access student: :all
  def list
    # courses that the current user(student) has registered for
    @courses = current_user.courses
  end

  def individual_progress
    @course = Course.find(params[:course_id])

    @total_percentage = individual_percentage(@course)

    @competency_aster_csv = 'id,score,weight,color,label\nFIS,50,0.5,#9E0041,Fisheries\nMAR,100,0.5,#C32F4B,Mariculture\nNP,100,1,#F47245,Natural Products\nCS,100,1,#FB9F59,Carbon Storage\n'
  end

  private
  def individual_percentage(course)
    total_score_in_course = 0
    questions = course.questions
    questions.each do |question|
      attempts = Attempt.where(question_id: question.id, user_id: current_user.id).order({ id: :asc })
      if attempts.any?  # there is at least one attempt
        latest = attempts.last
        total_score_in_course += latest.score
      end
    end

    if questions.any?
      total_percentage = 100 * total_score_in_course/questions.length/questions.length
    else
      total_percentage = 0
    end
    total_percentage
  end
end
