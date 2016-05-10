class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  mount_uploader :avatar, AvatarUploader
  has_friendship
  has_many :conversations, :foreign_key => :sender_id
  has_many :conversation_notifications

  validates :first_name, length: { maximum: 20 }
  validates :last_name, length: { maximum: 20 }

  def conversation_with(friend_id)
    Conversation.between(self.id, friend_id).first
  end
end
