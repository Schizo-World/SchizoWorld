class CreateProjectUsers < ActiveRecord::Migration
  def up
    create_table :project_users, :id => false do |t|
      t.integer :project_id
      t.integer :user_id
      t.boolean :admin
    end
  end

  def down
    drop_table :projects_users
  end
end