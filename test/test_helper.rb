# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  module OmniauthTwitterHepler
    def twitter_login_setup!
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
                                                                     'provider' => 'twitter',
                                                                     'uid' => '123456',
                                                                     'info' => {
                                                                       'nickname' => 'OmniAuth Twitter',
                                                                       'name' => 'OmniAuth Twitter Hepler',
                                                                       'image' => 'http://example.com'
                                                                     }
                                                                   })
      Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:twitter]
    end
  end
end
