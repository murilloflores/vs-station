class Lead < ActiveRecord::Base
  belongs_to :campaign

  def is_synced_with_salesforce
  	return self.salesforce_id != nil
  end

  def save_on_salesfoce!(current_client)

    strategy = Devise.omniauth_configs[:salesforce].strategy

    connection_params = { :oauth_token => current_client.token, 
      :refresh_token => current_client.refresh_token, 
      :instance_url  => current_client.instance_url, 
      :client_id => strategy.client_id, 
      :client_secret => strategy.client_secret
    }

    salesforce_client = Restforce.new connection_params

    params = {
      'FirstName' => self.name,
      'LastName' => self.last_name,
      'Email' => self.email,
      'Company' => self.company,
      'Title' => self.job_title,
      'Phone' => self.phone
    }

    salesforce_lead_id = salesforce_client.create!('Lead', params)
    self.salesforce_id = salesforce_lead_id
    self.save!
  end

  def remove_from_salesforce!(current_client)
  
    strategy = Devise.omniauth_configs[:salesforce].strategy

    connection_params = { :oauth_token => current_client.token, 
      :refresh_token => current_client.refresh_token, 
      :instance_url  => current_client.instance_url, 
      :client_id => strategy.client_id, 
      :client_secret => strategy.client_secret
    }

    salesforce_client = Restforce.new connection_params

    salesforce_client.destroy!('Lead', self.salesforce_id)
    self.salesforce_id = nil
    self.save!

  end
  
end
