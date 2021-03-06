class PostsController < ApplicationController
  respond_to :html, :json, :xml
  # GET /posts
  # GET /posts.json
  def index
    redirect_to Project.find(params[:project_id])
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /projects/:idproject/posts
  # POST /projects/:idproject/posts.json
  def create
    @post = Post.new(params[:post])
    @post.project = Project.find(params[:project_id])
    @post.user = current_user
    @post.save
    redirect_to @post.project
    
    #if @post.save
    #  respond_with do |format|
    #    format.html do
    #      if request.xhr?
    #        render :partial => "show", :layout => false, :status => :created, :locals => {:@post => @post}
    #      else
    #        redirect_to @post.project
    #      end
    #    end
    #  end
    #else
    #  respond_with do |format|
    #    format.html do
    #      if request.xhr?
    #        render :json => @post.errors, :status => :unprocessable_entity
    #      else
    #        render :action => :new, :status => :unprocessable_entity
    #      end
    #    end
    #  end
    #end

  #  respond_to do |format|
  #    if @post.save
  #      format.html { redirect_to @project, notice: 'Post was successfully created.' }
  #      format.json { render json: @post, status: :created, location: @post }
  #    else
  #      format.html { render action: "new" }
  #      format.json { render json: @post.errors, status: :unprocessable_entity }
  #    end
  #  end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :ok }
    end
  end
end
