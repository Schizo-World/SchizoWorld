class MessagesController < ApplicationController

  autocomplete :user, :login

  # GET /messages AND /messages/inbox
  def inbox
    if !current_user.nil?
      @mailbox = current_user.mailbox
      respond_to do |format|
        format.html # inbox.html.erb
        format.json { render json: @messages }
      end
    else
      redirect_to "/"
    end
  end

  def sentbox
    if current_user
      respond_to do |f|
        f.html # sentbox.html.erb
        f.json { render json: @mailbox.messages }
      end
    else
      redirect_to "/"
    end
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    mail = Mail.find(params[:id])

    if mail
      @conversation = mail.conversation
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @conversation }
      end
    end
  end

  # POST /messages
  # POST /messages.json
  def create
    # @TODO:
    # récupérer les infos de messages/_form ici et faire le send_mail en conséquence !
    recipients = []
    if params[:to_uid].is_a?(Array)
      params[:to_uid].each do |r|
        recipients[] = User.find(r)
      end
    elsif !params[:to_uid].nil?
      recipients[] = User.find(params[:to_uid])
    end
    if recipients.empty?
      if !!params[:reply_to]
        current_user.reply_to_all(Mail.find(:reply_to))
      end
    else
      current_user.send_message(recipients, params[:body])
    end

    redirect_to '/messages'
  end

  def reply
    mail = Mail.find(params[:mail_id])
    if !mail.nil? && !current_user.nil?
      current_user.reply_to_all(mail, params[:mail])
    end
  end

  # GET /messages/new
  # GET /messages/new?embedded=1
  def new
    #if(params[embedded] == 1)
      render :partial => "messages/embedded" 
    #
  end
end
