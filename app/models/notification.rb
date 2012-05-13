class Notification < ActiveRecord::Base
	belongs_to :user
	has_and_belongs_to_many :users

	def create(type, body, data)
		@n = Notification.new
		if data.is_a?(Array)
			if type == "project_update"
				p = Project.find(data[project_id])
				if p
					p.
				end
			elsif type == "announce_response"
				p = Project.find(data[project_id])
				if p
					
				end
			elsif type == "announce_new"
			end

			@n.user = current_user
			@n.body = body
			@n.type = type
			@n.users = users_by_type(type, data)
		end
	end

	# need to be called during the update/edition/creation of a project
	# n = Notification.new
	# n.build_for_project_update(project, update_type)
	# n.save
	# with update_type in : status, title, project
	def build_for_project_update(project, update_type)
		this.type = "project"
		this.data = project.id
		this.user = current_user
		pLink = link_to(project.title, project)
		if update_type == 'status'
				this.body = "Le statut du projet " + pLink + " est maintenant " + project.status
		elsif update_type == 'title'
				this.body = "Le titre du projet est maintenant " + pLink
		else
			this.body == "Le projet " + pLink + " a été mis à jour"
		break
		this.users = project.users
	end

	# need to be called during the creation of an announce "looking for someone for a project"
	# we look for every announces made for the inverse and put a notification for the users
	# n = Notification.new
	# n.build_for_job_announce(announce)
	# n.save
	def build_for_job_announce(announce)
		this.type = "project"
		this.data = announce.id
		this.user = current_user
		this.users = []
		Announce.where("type = 'job_for_a_film??' AND job = ''").each do |a|
			this.users[] = a.author
		end
		this.body = link_to(announce.title, announce)
	end

	# ...
end
