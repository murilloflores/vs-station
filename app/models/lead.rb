class Lead < ActiveRecord::Base
  belongs_to :campaign

  def is_synced_with_salesforce
  	return self.salesforce_id != nil
  end

  def save_on_salesfoce!(current_client)

    self.salesforce_id = Salesforceable.save_on_salesforce('Lead', self, current_client.refresh_token, current_client.instance_url)
    self.save!

  end

  def remove_from_salesforce!(current_client)
  
    Salesforceable.remove_from_salesforce('Lead', self.salesforce_id, current_client.refresh_token, current_client.instance_url)
    self.salesforce_id = nil
    self.save!

  end
  
end
