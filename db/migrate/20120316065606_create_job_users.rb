class CreateJobUsers < ActiveRecord::Migration
  def self.up
  	create_table :job_users, :id => false do |t|
      t.integer :job_id
      t.integer :user_id
	  t.integer :project_id
  	end
  end

  def self.down
  	drop_table :job_users
  end
end
