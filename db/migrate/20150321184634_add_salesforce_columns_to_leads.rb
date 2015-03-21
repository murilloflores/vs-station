class AddSalesforceColumnsToLeads < ActiveRecord::Migration
  def change
    add_column :leads, :salesforce_id, :string
  end
end
