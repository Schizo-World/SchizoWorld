class ProjectsController < ApplicationController
  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
    @announces = Announce.where("author_id = ? AND author_type = ?", @project.id, '1')
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])
    @announces = Announce.where("author_id = ? AND author_type = ?", @project.id, '1')

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end
  
  def adduser
    @project = Project.find(params[:id])
    user_to_add = User.find(params[:iduser])
    if not @project.users.include?(user_to_add)
      ProjectUser.create(:project => @project, :user => user_to_add, :admin => false)
    end
    redirect_to @project
  end
  
  def destroyuser
    @project = Project.find(params[:id])
    user_to_destroy = User.find(params[:iduser])
    @project.users.delete(user_to_destroy)
    redirect_to @project
  end
  
  def promoteuser
    @project = Project.find(params[:id])
    user_to_promote = User.find(params[:iduser])
    ProjectUser.find_by_project_id_and_user_id(@project,user_to_promote).update_attribute(:admin, true)
    redirect_to @project
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(params[:project])
    @project.status = "Etat zero"
    creator = current_user
    ProjectUser.create(:project => @project, :user => creator, :admin => true)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    @project.users.delete_all

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end
  
  def addjob
    @project = Project.find(params[:id])
    @user = User.find(params[:project][:user_id])
    
    if not (params[:user_job][:job_id].empty?)
      job = Job.find(params[:user_job][:job_id])
      if not @project.jobs.where("user_id = ?", @user.id).include?(job)
        JobUser.create(:project_id => @project.id, :job_id => job.id, :user_id => @user.id)
      end
    end
    
    redirect_to edit_project_path, notice: 'Job was successfully added.'
  end
  
  def destroyjob
    @project = Project.find(params[:id])
    @user = User.find(params[:iduser])
    job_to_destroy = Job.find(params[:idjob])
    JobUser.where("project_id = ? AND user_id = ? AND job_id = ?",@project.id, @user.id, job_to_destroy.id).delete_all
    redirect_to edit_project_path(@project)
  end
  
end