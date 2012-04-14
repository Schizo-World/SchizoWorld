class ApplicationController < ActionController::Base

	include AuthenticatedSystem

	protect_from_forgery

    def results
      @projects = Project.search(params[:search])
      @users = User.search(params[:search])
      @announces = Announce.search(params[:search])
    end

end
