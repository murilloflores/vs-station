class Lead < ActiveRecord::Base
  belongs_to :campaign

  def is_synced_with_salesforce
  	return self.salesforce_id != nil
  end

  
end
