class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, :omniauth_providers => [:facebook]

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first

    if user.nil? and belongs_to_group?(auth)
      user = create_user(auth)
    end

    user
  end


  def self.create_user auth
    User.create(name:     auth.extra.raw_info.name,
                provider: auth.provider,
                uid:      auth.uid,
                email:    auth.info.email,
                password: Devise.friendly_token[0,20]
               )
  end


  def self.belongs_to_group? auth
    members.include? auth.uid
  end

  def self.members
    graph = Koala::Facebook::API.new('CAACEdEose0cBADl7U7CJBxxseI2UPZA9QT9oIafpqiwNJnm4hzpiTbABHLfGZB9H9EvcZCZAnqrbvx8ZAzZCvyfZC2EqZBcTZB0hvyECXDZBZCrywnoq3OZCrs64OoLEc1Pm0M4vkEuK5ih1WiroPfSyAcvZBFnq2orp2o3MMtpT1EajAJ8rnET6cILHyMESVWIwIbmUZD')
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
