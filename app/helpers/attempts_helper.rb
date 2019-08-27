module AttemptsHelper
  def total_score_in_course(course_score_summary, student)
    sum = 0
    course_score_summary[student.id].keys.each do |k|
      next if course_score_summary[student.id][k]["latest_score"].nil?
      sum += course_score_summary[student.id][k]["latest_score"]
    end
    sum
  end
end

