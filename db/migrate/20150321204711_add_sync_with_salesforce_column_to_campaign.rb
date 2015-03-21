class AddSyncWithSalesforceColumnToCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :sync_with_salesforce, :boolean
  end
end
