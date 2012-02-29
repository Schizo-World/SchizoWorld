class ProjectsController < ApplicationController
  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    @project = Project.new
    @user = User.find(params[:id])

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
    ProjectUser.update_all(:admin => true)
    redirect_to @project
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(params[:project])
    creator = User.find(params[:iduser])
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
end
