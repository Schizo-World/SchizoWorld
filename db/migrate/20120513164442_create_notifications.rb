class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.text :body
      t.string :type
      t.integer :data
      t.timestamps
    end
    create_table :notifications_users do |t|
      t.integer :notification_id
      t.integer :user_id
      t.timestamps
    end
  end
end
