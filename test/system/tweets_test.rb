# frozen_string_literal: true

require 'application_system_test_case'

class TweetsTest < ApplicationSystemTestCase
  include OmniauthTwitterHepler

  setup do
    twitter_login_setup!
    visit root_url
    click_on 'Twitterでログイン'
  end

  test 'GET /tweets/new' do
    visit new_tweet_url
    assert_selector 'h1', text: '画像を投稿する'
  end

  test 'show description too long error message' do
    description_text = 'a' * 141
    fill_in 'ツイート本文', with: description_text
    click_on '投稿する'
    assert_text 'ツイート本文は140文字以内で入力してください'
  end

  test 'show media empty error message' do
    click_on '投稿する'
    assert_text '画像をえらんでください'
  end

  test 'no error message was shown' do
    file_path = Rails.root.join('test/fixtures/files/tweets/media/test_image.png')
    attach_file('画像をえらぶ', file_path)
    click_on '投稿する'
    assert_no_text 'ツイート本文は140文字以内で入力してください'
    assert_no_text '画像をえらんでください'
  end
end
