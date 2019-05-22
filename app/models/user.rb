class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  def full_name
    (first_name.nil? ? "":first_name) + ' ' + (last_name.nil? ? "":last_name)
  end
end