class Post < ActiveRecord::Base
	belongs_to :user
	belongs_to :project

	scope :latest, order("created_at DESC")

	acts_as_commentable

	attr_accessible :body


end
