# frozen_string_literal: true

require 'test_helper'

class SessionsHelperTest < ActionView::TestCase
  setup do
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
    @session_user = auth_hash
  end

  test 'log_in(user)' do
    user = users(:alice)
    assert_equal @session_user[:uid], log_in(user)
  end

  test 'current_user' do
    user = users(:alice)
    assert_equal @session_user[:uid], user.uid
  end

  test 'logged_in?' do
    assert_not_equal @session_user[:uid], nil
  end

  test 'log_out' do
    @session_user.delete(:uid)
    assert_nil @session_user[:uid]
  end
end
