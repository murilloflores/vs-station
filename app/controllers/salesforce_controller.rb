class SalesforceController < ApplicationController

  before_action :set_lead

  def send_to_salesforce
  
    strategy = Devise.omniauth_configs[:salesforce].strategy

    salesforce_client = Restforce.new :oauth_token => current_client.token, 
      :refresh_token => current_client.refresh_token, 
      :instance_url  => current_client.instance_url, 
      :client_id => strategy.client_id, 
      :client_secret => strategy.client_secret

    params = {
      'FirstName' => @lead.name,
      'LastName' => @lead.last_name,
      'Email' => @lead.email,
      'Company' => @lead.company,
      'Title' => @lead.job_title,
      'Phone' => @lead.phone
    }

    salesforce_lead_id = salesforce_client.create!('Lead', params)

    if salesforce_lead_id
      @lead.salesforce_id = salesforce_lead_id
      @lead.save!
      redirect_to campaign_path(@lead.campaign)
    else
      #TODO improve error treatment in here
      redirect_to campaign_path(@lead.campaign), :flash => { :error => "Could not sync to salesforce" }
    end

  end


  def remove_from_salesforce
    strategy = Devise.omniauth_configs[:salesforce].strategy

    salesforce_client = Restforce.new :oauth_token => current_client.token, 
      :refresh_token => current_client.refresh_token, 
      :instance_url  => current_client.instance_url, 
      :client_id => strategy.client_id, 
      :client_secret => strategy.client_secret

    if salesforce_client.destroy('Lead', @lead.salesforce_id)
      @lead.salesforce_id = nil
      @lead.save!
      redirect_to campaign_path(@lead.campaign)
    else
      #TODO improve error treatment in here
      redirect_to campaign_path(@lead.campaign), :flash => { :error => "Could not delete lead from salesforce" }
    end

  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_lead
      @lead = Lead.find(params[:lead_id])
    end
  

end