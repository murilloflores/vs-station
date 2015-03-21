class Clients::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def salesforce

  	current_client.uid = request.env["omniauth.auth"].uid
  	current_client.provider = request.env["omniauth.auth"].provider
  	current_client.refresh_token = request.env["omniauth.auth"].credentials.refresh_token
  	current_client.instance_url = request.env["omniauth.auth"].credentials.instance_url
  	current_client.token = request.env["omniauth.auth"].credentials.token

  	current_client.save!

    redirect_to campaigns_url

  end

end