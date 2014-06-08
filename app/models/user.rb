class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, :omniauth_providers => [:facebook]

  def self.find_or_create_by_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first

    if user.nil? and belongs_to_group?(auth)
      user = create_user(auth)
    end

    user
  end

  def self.create_user auth
    User.create(name:               auth.extra.raw_info.name,
                provider:           auth.provider,
                uid:                auth.uid,
                email:              auth.info.email,
                password:           Devise.friendly_token[0,20],
                oauth_access_token: auth.credentials.token

               )
  end

  def self.belongs_to_group? auth
    return true if auth.info.email == ENV['FACEBOOK_ADMIN_EMAIL']
    members.include? auth.uid
  end

  def self.members
    admin_user = User.find_by_email ENV['FACEBOOK_ADMIN_EMAIL']
    graph = Koala::Facebook::API.new(admin_user.oauth_access_token)
    members = graph.get_connections ENV['FACEBOOK_GROUP'], 'members', batch_params
    members.collect {|m| m['id']}
  end

  def self.batch_params
    {
      :fields => 'id'
    }
  end

  private_class_method :create_user, :belongs_to_group?, :members, :batch_params
end
