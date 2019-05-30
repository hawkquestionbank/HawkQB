class AdminDashboardController < ApplicationController
  access admin: :all

  def list
  	@courses = Course.all
  end
end
