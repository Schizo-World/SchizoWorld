class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :description
      t.string :city
	  t.string :status

      t.timestamps
    end
  end
end
