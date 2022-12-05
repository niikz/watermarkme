# frozen_string_literal: true

class TweetsController < ApplicationController
  before_action :require_login

  def new; end

  private

  def twitter_client
    TwitterAPI::Client.new({
                             consumer_key: ENV['TWITTER_API_KEY'],
                             consumer_secret: ENV['TWITTER_API_SECRET'],
                             token: current_user.token,
                             token_secret: current_user.secret
                           })
  end
end
