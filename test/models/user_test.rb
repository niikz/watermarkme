# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'new user' do
    auth_hash = OmniAuth::AuthHash.new({
                                         'provider' => 'twitter',
                                         'uid' => '123456',
                                         'info' => {
                                           'nickname' => 'OmniAuth Twitter',
                                           'name' => 'OmniAuth Twitter Hepler',
                                           'image' => 'http://example.com'
                                         },
                                         'credentials' => {
                                           'token' => 'test_token',
                                           'secret' => 'test_token_secret'
                                         }
                                       })
    assert_difference 'User.count' do
      User.find_or_create_from_auth_hash(auth_hash)
    end
  end

  test 'existing user' do
    auth_hash = OmniAuth::AuthHash.new({
                                         'provider' => 'twitter',
                                         'uid' => '18651126',
                                         'info' => {
                                           'nickname' => 'alice',
                                           'name' => 'alice world',
                                           'image' => 'http://example.com/alice.jpg'
                                         },
                                         'credentials' => {
                                           'token' => 'token',
                                           'secret' => 'secret'
                                         }
                                       })
    user = User.find_or_create_from_auth_hash(auth_hash)
    assert_equal user.uid, users(:alice).uid
    assert_no_difference 'User.count' do
      User.find_or_create_from_auth_hash(auth_hash)
    end
  end
end
