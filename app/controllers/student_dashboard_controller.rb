class StudentDashboardController < ApplicationController
  access student: :all
  def list
    # courses that the current user(student) has registered for
    @courses = current_user.courses
  end
end
