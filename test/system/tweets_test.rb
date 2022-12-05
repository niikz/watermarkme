# frozen_string_literal: true

require 'application_system_test_case'

class TweetsTest < ApplicationSystemTestCase
  include OmniauthTwitterHepler

  setup do
    twitter_login_setup!
    visit root_url
    click_on 'ログイン'
  end

  test 'GET /tweets/new' do
    visit new_tweet_url
    assert_selector 'h1', text: '画像を投稿する'
  end
end
