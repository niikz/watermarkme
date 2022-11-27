# frozen_string_literal: true

require 'application_system_test_case'

class SessionsTest < ApplicationSystemTestCase
  include OmniauthTwitterHepler

  test 'login using twitter' do
    twitter_login_setup!
    visit root_url
    assert_selector 'h1', text: 'WaterMark Me'
    click_on 'ログイン'
    assert_text 'ログインしました'
  end

  test 'logout' do
    twitter_login_setup!
    visit root_url
    click_on 'ログイン'
    assert_text 'ログインしました'
    click_on 'ログアウト'
    assert_text 'ログアウトしました'
  end
end
