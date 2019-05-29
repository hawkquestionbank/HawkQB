class InstructorDashboardController < ApplicationController

  access [:instructor, :admin] => :all

  def list
    @courses = current_user.own_courses
  end
end
