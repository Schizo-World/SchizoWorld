class ApplicationController < ActionController::Base

	include AuthenticatedSystem

	protect_from_forgery

	def index
	end

end
