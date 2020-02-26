class StudentDashboardController < ApplicationController
  access student: :all
  def list
    # courses that the current user(student) has registered for
    @courses = current_user.courses
  end

  def individual_progress
    @course = Course.find(params[:course_id])
    @total_percentage = individual_percentage(@course)

    @competency_aster_csv = prepare_aster_csv(@course)

      #@competency_aster_csv = 'id,score,weight,color,label\nFIS,50,0.5,#9E0041,Fisheries\nMAR,100,0.5,#C32F4B,Mariculture\nNP,100,1,#F47245,Natural Products\nCS,100,1,#FB9F59,Carbon Storage\n'
  end

  private
  def prepare_aster_csv (course)
    asterplot_colors = ["#78C2AD","#56CC9D","#FFCE67","#FCDE9C","F3969A","F4BBD3","#FF7851","#FF7851","BF1519","#6CC3D5","#3D92A3","#343A40","#020202","#F8F9FA","#53A548","#888888","#E6CCBE","#C29878","#5F5449","#9278C2","#411E59"]

    questions = course.questions
    micro_credentials = course.micro_credentials

    scores_on_micro_credentials ={}
    micro_credentials.each do |mc|
      hash_for_mc = {"id"=> mc.identifier, "title"=>mc.title, "total_question_count" => 0, "total_score"=> 0}
      scores_on_micro_credentials[mc.identifier] = hash_for_mc
    end

    questions.each do |question|
      attempts = Attempt.where(question_id: question.id, user_id: current_user.id).order({ id: :asc })
      if attempts.any?  # there is at least one attempt
        latest = attempts.last

        mc_required_by_current_question = question.micro_credentials
        score_current_question = latest.score
        mc_required_by_current_question.each do |mc_required|
          scores_on_micro_credentials[mc_required.identifier]["total_question_count"] += 1
          scores_on_micro_credentials[mc_required.identifier]["total_score"] += score_current_question
        end
      end
    end

    competency_aster_csv = 'id,score,weight,color,label\n'

    color_counter = 0

    scores_on_micro_credentials.each do |mc_identifier, mc_hash|
      competency_aster_csv += mc_hash["id"]+','
      if mc_hash["total_question_count"] != 0
        correct_rate = 100 * mc_hash["total_score"]/mc_hash["total_question_count"]
        competency_aster_csv += correct_rate.to_s + ','
      else
        competency_aster_csv += '0,'
      end

      weight = mc_hash["total_question_count"].to_s + ','
      competency_aster_csv += weight

      color = asterplot_colors[color_counter%20]
      color_counter += 1
      competency_aster_csv += color + ','

      competency_aster_csv += mc_hash["title"].gsub(',',' ')

      competency_aster_csv += '\n'
    end
    competency_aster_csv
  end

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
      total_percentage = 100 * total_score_in_course/questions.length
    else
      total_percentage = 0
    end
    total_percentage
  end
end
