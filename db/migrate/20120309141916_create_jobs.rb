class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :label
      t.string :description

      t.timestamps
    end
  end
end
