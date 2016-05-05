class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  mount_uploader :avatar, AvatarUploader
  has_friendship
  has_many :conversations, :foreign_key => :sender_id

  validates :first_name, length: { maximum: 20 }
  validates :last_name, length: { maximum: 20 }
end
