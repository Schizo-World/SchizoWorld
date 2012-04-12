class AnnouncesController < ActionController::Base
  
  def index
  end

  # render new.rhtml
  def new
    @announce = Announce.new
  end
 
  def create
    @announce = Announce.new(params[:announce])
    @announce.author_type = :author_type
    @announce.statut = 0
    respond_to do |format|
      if @announce.save
        format.html { redirect_to :profile, notice: 'Annonce was successfully created.' }
        format.json { render json: :profile, status: :created, location: @announce }
      else
        format.html { render action: "new" }
        format.json { render json: @announce.errors, status: :unprocessable_entity }
      end
    end
  end

  def show 
    @announce = Announce.find(params[:id])
  end
  
end
