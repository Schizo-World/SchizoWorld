class Project < ActiveRecord::Base
  
  has_many :announces, :foreign_key => "author_id"
  has_many:announce_candidates, :foreign_key => "author_id"

	has_many :project_users
  has_many :users, :through => :project_users

    has_attached_file :avatar_project, :styles => { :large => "180x180#", :medium => "100x100#", :small => "50x50#", :thumb => "30x30#" }

    attr_accessible :name, :description, :city, :avatar_project
  
  has_many :job_users
  has_many :jobs, :through => :job_users

  def self.search(search)
    if search
      find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end
  
end