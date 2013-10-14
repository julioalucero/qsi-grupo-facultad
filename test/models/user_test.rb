require 'test_helper'

class UserTest < ActiveSupport::TestCase

  OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
    :provider => 'facebook',
    :uid => '32323232',
    :info => {
      :email => 'user@example.com'
    },
    :extra => {
      :raw_info => {
        :name => "Michael Scott",
      },
    },
  })



  describe 'When a user belongs to the group' do
    test "Create the user" do
      User.stub(:members, ["32323232", "1569878714"]) do
        User.find_for_facebook_oauth(OmniAuth.config.mock_auth[:facebook])

        assert_equal User.count, 1
      end
    end
  end

  describe 'When a user does not belongs to the group' do
    test "Create the user" do
      User.stub(:members, ["666232233", "1569878714"]) do
        User.find_for_facebook_oauth(OmniAuth.config.mock_auth[:facebook])

        assert_equal User.count, 0
      end
    end
  end
end
