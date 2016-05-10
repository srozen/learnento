class CreateConversationNotifications < ActiveRecord::Migration
  def change
    create_table :conversation_notifications do |t|
      t.references :user, index: true, foreign_key: true
      t.references :conversation, index: true, foreign_key: true
      t.boolean :status, null: false, default: false

      t.timestamps null: false
    end
  end
end
