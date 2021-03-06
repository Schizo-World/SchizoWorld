class Announce < ActiveRecord::Base
  
  belongs_to:job
  belongs_to:user
  belongs_to:project
  
  has_many:announce_candidates

  def self.search(search)
    if search
      find(:all, :conditions => ['title LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end
  
end
