# frozen_string_literal: true

require 'application_system_test_case'

class WelcomeTest < ApplicationSystemTestCase
  test 'GET /' do
    visit '/'
    assert_selector 'h1', text: '画像に透かしを入れてツイート'
  end
end
