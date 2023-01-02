# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.production?
    provider :twitter, Rails.application.credentials.twitter[:twitter_api_key], Rails.application.credentials.twitter[:twitter_api_secret]
  else
    provider :twitter, ENV['TWITTER_API_KEY'], ENV['TWITTER_API_SECRET']
  end
end
