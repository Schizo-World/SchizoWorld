class Authorization < ActiveRecord::Base

	belongs_to :user
	validates :provider, :uid, :presence => true

	def self.find_or_create(auth_hash)
	  unless auth = find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
	  	user_name = User.where(:login => auth_hash["user_info"]["name"])
	  	if auth_hash["provider"] == "facebook"
	  		url_splitted = auth_hash["user_info"]["image"].split('=')
	  		user = User.create!(:login => auth_hash["user_info"]["name"], :email => auth_hash["user_info"]["email"], :password => "emptypass", :password_confirmation => "emptypass", :url_img => url_splitted[0])
	    elsif auth_hash["provider"] == "twitter"
	    	user = User.create!(:login => auth_hash["user_info"]["name"], :email => auth_hash["user_info"]["email"], :password => "emptypass", :password_confirmation => "emptypass")
	    elsif auth_hash["provider"] == "google"
	    	user = User.create!(:login => auth_hash["user_info"]["name"], :email => auth_hash["user_info"]["email"], :password => "emptypass", :password_confirmation => "emptypass")
	    end
  
	    auth = create :user => user, :provider => auth_hash["provider"], :uid => auth_hash["uid"]
	  end
	 
	  auth
	end
	
end
