class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  # include AuthenticatedSystem
  
  def index
    if current_user != nil
      @user = User.find(current_user.id);
    end
    @announces = Announce.where("author_id = ? AND author_type = ?", current_user.id, '0')
  end

  # render new.rhtml
  def new
    @user = User.new
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
            # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      self.current_user = @user # !! now logged in
      redirect_back_or_default(:profile, :notice => "Thanks for signing up!  We're sending you an email with your activation code.")
    else
      flash.now[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end

  def show 
    @user = User.find(params[:id])
    if current_user != nil
      @announces = Announce.where("author_id = ? AND author_type = ?", current_user.id, '0')
    end
  end

  def edit
    @user = User.find(params[:id]) 
    @announces = Announce.where("author_id = ? AND author_type = ?", current_user.id, '0')
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user]) 
        format.html {redirect_to :profile, notice: 'User was successfully updated'}
        format.json {head :no_content}
      else
        format.html {render action: "edit"}
        format.json {render json: @user.errors, status: :unprocessable_entity}
      end
    end
  end
  
  def addjob
    @user = current_user
    job = Job.find(params[:user_job][:job_id])
      if not @user.jobs.where("project_id IS NULL AND user_id = ?", @user.id).include?(job)
        @user.jobs << job
      end
    redirect_to edit_user_path, notice: 'Tag was successfully added.'
  end
  
  def destroyjob
    @user = User.find(params[:id])
    job_to_destroy = Job.find(params[:idjob])
    JobUser.where("project_id IS NULL AND user_id = ? AND job_id = ?", @user.id, job_to_destroy.id).delete_all
    redirect_to edit_user_path(@user)
  end

  def mail
    type = "inbox"
    if params[:type] == "sent"
      type = params[:type]
    end
    @user = current_user
    @mail = @user.mailbox[type].latest_mail
    render "messages/index", :locales => {:box => type}
  end

end