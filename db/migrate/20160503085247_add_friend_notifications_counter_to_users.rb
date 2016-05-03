class AddFriendNotificationsCounterToUsers < ActiveRecord::Migration
  def change
    add_column :users, :active_friend_notifications, :integer, default: 0
  end
end
