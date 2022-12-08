# frozen_string_literal: true

class TweetsController < ApplicationController
  before_action :require_login

  def new
    @tweet = TweetForm.new
  end

  def create
    @tweet = TweetForm.new(tweet_params)
    user = current_user
    if @tweet.save(user)
      redirect_to new_tweet_path, notice: 'ツイートを投稿しました'
    else
      render :new
    end
  end

  private

  def tweet_params
    params.require(:tweet_form).permit(:description)
  end
end
