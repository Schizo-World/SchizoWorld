class Announce < ActiveRecord::Base
  
  belongs_to:job
  belongs_to:user
  belongs_to:project
  
end
