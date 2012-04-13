class AnnouncesController < ApplicationController
  
  def index
    @announces = Announce.find(:all)
  end

  # render new.rhtml
  def new
    @announce = Announce.new
  end
 
  def create
    @announce = Announce.new(params[:announce])
    @announce.author_id = params[:author_id]
    @announce.author_type = params[:author_type]
    @announce.job_id = params[:user_job][:job_id]
    @announce.statut = 0

    if params[:author_type] == 0
      redirection = :profile
    else
      redirection = project_path(params[:author_id])
    end

    respond_to do |format|
      if @announce.save
        format.html { redirect_to redirection, notice: 'Annonce was successfully created.' }
        format.json { render json: redirection, status: :created, location: @announce }
      else
        format.html { render action: "new" }
        format.json { render json: @announce.errors, status: :unprocessable_entity }
      end
    end
  end

  def show 
    @announce = Announce.find(params[:id])
  end

  def postuler
    redirect_to :profile
  end
  
end
