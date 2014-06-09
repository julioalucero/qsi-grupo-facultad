namespace :facebook_group_users do

  desc "Load all the facebook users of the group"
  task :load_all => :environment do
    begin
      puts "Fetching User from facebook group"

      admin_user = User.find_by_email ENV['FACEBOOK_ADMIN_EMAIL']
      graph = Koala::Facebook::API.new(admin_user.oauth_access_token)
      members = graph.get_connections ENV['FACEBOOK_GROUP'], 'members', User::batch_params
      User::create_batch_facebook_group_users(members)
    end
  end
end

