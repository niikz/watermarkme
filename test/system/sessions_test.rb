# frozen_string_literal: true

require 'application_system_test_case'

class SessionsTest < ApplicationSystemTestCase
  include OmniauthTwitterHepler

  test 'login using twitter' do
    twitter_login_setup!
    visit root_url
    click_on 'Twitterでログイン'
    assert_text 'ログインしました'
  end

  test 'logout' do
    twitter_login_setup!
    visit root_url
    click_on 'Twitterでログイン'
    visit new_tweet_url
    find('.dropdown').click
    find('.dropdown ul li a', text: 'ログアウト').click
    assert_text 'ログアウトしました'
  end

  test 'require logged in to visit the posts page' do
    visit new_tweet_url
    assert_no_selector 'h1', text: '画像を投稿する'
    assert_text 'ログインしてください'
  end
end
