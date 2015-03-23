class Campaign < ActiveRecord::Base
  validates :name, length: { minimum: 2 }
  belongs_to :client
  has_many :leads, :dependent => :delete_all
end
