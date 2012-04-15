class AnnounceCandidate < ActiveRecord::Base
  
  belongs_to:announce
  belongs_to:user
  belongs_to:project
  
end
