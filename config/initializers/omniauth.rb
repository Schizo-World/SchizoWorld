OmniAuth.config.full_host = "http://localhost:3000"

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '166417706809142', '89a2c50dcd0895c546b0418fb7f364e4', {:client_options => {:ssl => {:ca_path => "/etc/ssl/certs"}}}
  # provider :twitter, 'oJiNsgt5vepJaXR5ETd8DA', '8GsWfFX0TPB64E6qseb7TJcQBPjP7fNyI3XzpURUoh8'
  # provider :google, '1086156846633.apps.googleusercontent.com', 'WuKTB_x2nfwtvmI67unno1lY', :scope => 'https://mail.google.com/mail/feed/atom/'
  # provider :linked_in, 'CONSUMER_KEY', 'CONSUMER_SECRET'
end
