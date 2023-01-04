# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, Rails.application.credentials.dig(:twitter, :twitter_api_key), Rails.application.credentials.dig(:twitter, :twitter_api_secret)
end
