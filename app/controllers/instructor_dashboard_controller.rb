class InstructorDashboardController < ApplicationController
  access instructor: :all
  def list
    @courses = Course.where(creator_user_id: current_user.id)
  end
end
