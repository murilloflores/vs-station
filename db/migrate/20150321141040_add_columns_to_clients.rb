class AddColumnsToClients < ActiveRecord::Migration
  def change
    add_column :clients, :provider, :string
    add_column :clients, :uid, :string
    add_column :clients, :refresh_token, :string
  end
end
