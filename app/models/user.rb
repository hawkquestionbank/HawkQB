class User < ActiveRecord::Base
  ############################################################################################
  ## PeterGate Roles                                                                        ##
  ## The :user role is added by default and shouldn't be included in this list.             ##
  ## The :root_admin can access any page regardless of access settings. Use with caution!   ##
  ## The multiple option can be set to true if you need users to have multiple roles.       ##
  petergate(roles: [:admin, :instructor, :student], multiple: false)                        ##

  ############################################################################################ 
 

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  has_many :courses, class_name: 'Course', foreign_key: 'creator_user_id', dependent: :destroy

  def full_name
    combined_name = (first_name.nil? ? "":first_name) + ' ' + (last_name.nil? ? "":last_name)
    if combined_name.length <= 1
      combined_name = "please update your user name"
    end
    combined_name
  end
end