class CreateAnnounceCandidates < ActiveRecord::Migration
  def change
    create_table :announce_candidates do |t|
      t.integer :announce_id
      t.integer :author_id
      t.boolean :accepted
    end
  end
end
