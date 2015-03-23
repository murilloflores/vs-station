class Campaign < ActiveRecord::Base
  belongs_to :client
  has_many :leads, :dependent => :delete_all
end
