# OmniAuth.config.full_host = "https://mogushare.net"
Rails.application.config.middleware.use OmniAuth::Builder do
  configure do |config|
    config.full_host = "https://mogushare.net"
  end
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
end
