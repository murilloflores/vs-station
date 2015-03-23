class Lead < ActiveRecord::Base
  belongs_to :campaign

  salesforceable_as 'Lead', 
    client_id: '3MVG9sG9Z3Q1RlbdYs9verSsP3skmndtEoJ7tpS4VXcCrDLw2PCIXeC_uTaMoRa9y003ujOR7SQjTIa_hmzFU', 
    client_secret: '661783981437692681',
    fields_mapping: {
      'name' => 'FirstName',
      'last_name' => 'LastName',
      'email' => 'Email',
      'company' => 'Company',
      'job_title' => 'Title',
      'phone' => 'Phone'
    }
  
end
