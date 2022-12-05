# frozen_string_literal: true

class TweetsController < ApplicationController
  before_action :require_login

  def new; end

  def create
    response = twitter_client.statuses_update({
                                                status: tweet_params
                                              })
    JSON.pretty_generate(JSON.parse(response.body))
    redirect_to new_tweet_path, notice: 'ツイートを投稿しました'
  end

  private

  def twitter_client
    TwitterAPI::Client.new({
                             consumer_key: ENV['TWITTER_API_KEY'],
                             consumer_secret: ENV['TWITTER_API_SECRET'],
                             token: current_user.token,
                             token_secret: current_user.secret
                           })
  end

  def tweet_params
    params[:description]
  end
end
