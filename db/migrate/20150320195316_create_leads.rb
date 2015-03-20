class CreateLeads < ActiveRecord::Migration
  def change
    create_table :leads do |t|
      t.string :name
      t.string :last_name
      t.string :email
      t.string :company
      t.string :job_title
      t.string :phone
      t.string :website
      t.belongs_to :campaign, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
