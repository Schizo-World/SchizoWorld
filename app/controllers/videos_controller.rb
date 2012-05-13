class VideosController < InheritedResources::Base

  def new
    @project = Project.find(params[:project_id])
    @video = Video.new
    @nodes = get_tree(0)
    File.open("public/js/libs/tree_data.json", "w"){ #Specifier ou créer le fichier
      |f| f.write(@nodes.to_json # Ecrire dans le fichier le tableau "nodes" précédement créé.
    )}
  end

  def upload
    @video = Video.create(params[:video])
    @video.update_attribute(:parent_id, params[:parent_id])
    @project = Project.find(params[:video][:project_id])
    if @video
      @upload_info = Video.token_form(params[:video], save_video_new_video_url(:video_id => @video.id))
      @project.update_attribute(:status, "Fini")
    else
      respond_to do |format|
        format.html { render "/videos/new" }
      end
    end
  end

  def update
    @video     = Video.find(params[:id])
    @result    = Video.update_video(@video, params[:video])
    respond_to do |format|
      format.html do
        if @result
          redirect_to @video, :notice => "video successfully updated"
        else
          respond_to do |format|
            format.html { render "/videos/_edit" }
          end
        end
      end
    end
  end

  def save_video
    @video = Video.find(params[:video_id])
    if params[:status].to_i == 200
      @video.update_attributes(:yt_video_id => params[:id].to_s, :is_complete => true)
      Video.delete_incomplete_videos
      nodes = get_tree(0)
      File.open("public/js/libs/tree_data.json", "w"){ #Specifier ou créer le fichier
        |f| f.write(nodes.to_json # Ecrire dans le fichier le tableau "nodes" précédement créé.
      )}
    else
      Video.delete_video(@video)
    end
    redirect_to "/", :notice => "video successfully uploaded"
  end

  def destroy
    @video = Video.find(params[:id])
    if Video.delete_video(@video)
      flash[:notice] = "video successfully deleted"
    else
      flash[:error] = "video unsuccessfully deleted"
    end
    redirect_to videos_path
  end

  def add_comment
    @video = Video.find(params[:id])
    @project = Project.find(params[:video][:project_id])
    @video.create_comment(params[:video][:comment])
    @video.comments.last.update_attribute(:user_id, params[:video][:user_id])
    #if @video.create_comment(params[:video][:comment])
    #  flash[:notice] = "Comment has been sucessfully added."
    #else
    #  flash[:error] = "Sorry the comment has not been added."
    #end
    redirect_to project_path(@project, :public => true)  
  end

  def has_child(id)
    if (Video.exists?(Video.find_by_parent_id(id)))
      result = true
    else
      result = false
    end
    return result
  end
    
  def get_tree(id)
    
    childrens = Video.where(:parent_id => id)
    elements = Array.new
    
    childrens.each do |video|

      project = Project.find(video.project_id)
      img = project.avatar_project_file_name
      img_url = "/system/avatar_projects/" + video.project_id.to_s + "/small/" + img

      if (has_child(video.id))
        element = {'id' => video.id, 'title' => video.title, 'img' => img_url, 'children' => get_tree(video.id) }
      else
        element = {'id' => video.id, 'title' => video.title, 'children' => [] }
      end
      
      elements << element
      
    end
      
    return elements      
  end

  protected
    def collection
      @videos ||= end_of_association_chain.completes
    end

end
