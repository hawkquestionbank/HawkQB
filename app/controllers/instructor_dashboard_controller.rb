class InstructorDashboardController < ApplicationController

  access [:instructor, :admin] => :all

  def list
    @courses = current_user.own_courses
    @micro_credentials = current_user.own_micro_credentials
  end
end
