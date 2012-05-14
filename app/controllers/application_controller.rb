class ApplicationController < ActionController::Base

	include AuthenticatedSystem
	include ActsAsMessageable

	protect_from_forgery

    helper_method :yt_client

    def results
      @projects = Project.search(params[:search])
      @users = User.search(params[:search])
      @announces = Announce.search(params[:search])
    end

    def yt_client
      @yt_client ||= YouTubeIt::Client.new(:username => YouTubeITConfig.username , :password => YouTubeITConfig.password , :dev_key => YouTubeITConfig.dev_key)
    end

end
