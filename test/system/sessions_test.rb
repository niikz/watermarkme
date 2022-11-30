# frozen_string_literal: true

require 'application_system_test_case'

class SessionsTest < ApplicationSystemTestCase
  include OmniauthTwitterHepler

  test 'login using twitter' do
    twitter_login_setup!
    visit root_url
    click_on 'ログイン'
    visit tweets_url
    assert_text 'OmniAuth Twitterさん、こんにちは'
  end

  test 'logout' do
    twitter_login_setup!
    visit root_url
    click_on 'ログイン'
    visit tweets_url
    click_on 'ログアウト'
    assert_text 'ログアウトしました'
  end
end
