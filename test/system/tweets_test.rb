# frozen_string_literal: true

require 'application_system_test_case'

class TweetsTest < ApplicationSystemTestCase
  test 'GET /tweets' do
    visit '/tweets'
    assert_selector 'h1', text: '画像を投稿する'
  end
end
