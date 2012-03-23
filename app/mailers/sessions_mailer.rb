class SessionsMailer < ActionMailer::Base

  def signup_notification(sessions)
    setup_email(sessions)
    @subject    += 'Please activate your new account'
       @url  = "http://YOURSITE/activate/#{sessions.activation_code}"
  end
  
  def activation(sessions)
    setup_email(sessions)
    @subject    += 'Your account has been activated!'
    @url  = "http://YOURSITE/"
  end
  
  protected

  def setup_email(sessions)
    @recipients  = "#{sessions.email}"
    @from        = "ADMINEMAIL"
    @subject     = "[YOURSITE] "
    @sent_on     = Time.now
    @sessions = sessions
  end

end
