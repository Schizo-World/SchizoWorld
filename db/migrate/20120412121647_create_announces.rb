class CreateAnnounces < ActiveRecord::Migration
  def change
    create_table :announces do |t|
      t.string :title
      t.string :location
      t.integer :job_id
      t.string :description
      t.integer :author_id
      t.integer :author_type
      t.integer :statut

      t.timestamps
    end
  end
end
