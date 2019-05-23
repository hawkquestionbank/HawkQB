class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  def full_name
    combined_name = (first_name.nil? ? "":first_name) + ' ' + (last_name.nil? ? "":last_name)
    if combined_name.length <= 1
      combined_name = "please update your user name"
    end
    combined_name
  end
end