class AddMoreColumnsToClients < ActiveRecord::Migration
  def change
    add_column :clients, :token, :string
    add_column :clients, :instance_url, :string
  end
end
