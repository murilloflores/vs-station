class Clients::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def salesforce

    current_client.uid = request.env["omniauth.auth"].uid
    current_client.provider = request.env["omniauth.auth"].provider
    current_client.refresh_token = request.env["omniauth.auth"].credentials.refresh_token
    current_client.instance_url = request.env["omniauth.auth"].credentials.instance_url
    current_client.token = request.env["omniauth.auth"].credentials.token

    current_client.save!

    redirect_to clients_services_path

  end

  def unlink

    current_client.uid = nil
    current_client.provider = nil
    current_client.refresh_token = nil
    current_client.instance_url = nil
    current_client.token = nil

    current_client.save!

    redirect_to clients_services_path

  end

  def failure
    redirect_to clients_services_path, :alert => "Sorry, we could not complete your request. Message from service: "+params['error_description']
  end

  def services
  end

end