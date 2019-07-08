class AdminDashboardController < ApplicationController
  #access admin: :all

  def list
    @courses = Course.all
    @micro_credentials = MicroCredential.all
  end

end
