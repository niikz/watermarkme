# frozen_string_literal: true

require 'application_system_test_case'

class WelcomeTest < ApplicationSystemTestCase
  test 'GET /' do
    visit '/'
    assert_text 'WaterMark Me'
  end
end
