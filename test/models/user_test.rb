require 'test_helper'

class UserTest < ActiveSupport::TestCase

  OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
    :provider => 'facebook',
    :uid => '32323232',
    :info => {
      :email => 'user@example.com'
    },
    :credentials => {
      :token => 'sjklsdfjsaf9sdfj3i29232j2j32',
    },
    :extra => {
      :raw_info => {
        :name => "Michael Scott",
      },
    },
  })


  describe 'When there is no user' do
    test "Create the facebook admin user" do
      ENV['FACEBOOK_ADMIN_EMAIL'] = 'user@example.com'
      User.find_for_facebook_oauth(OmniAuth.config.mock_auth[:facebook])
      user = User.last

      assert_equal User.count, 1
    end
  end

  describe 'When a user belongs to the group' do
    test "Create the user" do
      User.stub(:members, ["32323232", "1569878714"]) do
        User.find_for_facebook_oauth(OmniAuth.config.mock_auth[:facebook])
        user = User.last

        assert_equal User.count,              1
        assert_equal user.email,              'user@example.com'
        assert_equal user.name,               'Michael Scott'
        assert_equal user.uid,                '32323232'
        assert_equal user.provider,           'facebook'
        assert_equal user.oauth_access_token, 'sjklsdfjsaf9sdfj3i29232j2j32'
      end
    end
  end

  describe 'When a user does not belongs to the group' do
    test "not create the user" do
      User.stub(:members, ["666232233", "1569878714"]) do
        ENV['FACEBOOK_ADMIN_EMAIL'] = 'nobody@example.com'
        User.find_for_facebook_oauth(OmniAuth.config.mock_auth[:facebook])

        assert_equal User.count, 0
      end
    end
  end
end
