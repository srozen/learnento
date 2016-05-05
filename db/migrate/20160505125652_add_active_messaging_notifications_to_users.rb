class AddActiveMessagingNotificationsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :active_messaging_notifications, :integer, default: 0
  end
end
