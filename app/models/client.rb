class Client < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:salesforce]


  def is_connected_to_salesforce
  	return self.uid != nil && self.provider != nil && self.refresh_token != nil
  end

end
