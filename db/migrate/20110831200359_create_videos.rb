class CreateVideos < ActiveRecord::Migration
  def self.up
    create_table :videos do |t|
      t.string   :title
      t.string   :description
      t.string   :yt_video_id
      t.boolean  :is_complete, :default => false
      t.integer  :parent_id
      t.integer  :project_id
      t.timestamps
    end
  end

  def self.down
    drop_table :videos
  end
end
