class Lead < ActiveRecord::Base
  belongs_to :campaign

  salesforceable_as 'Lead', 
    client_id: '3MVG9sG9Z3Q1RlbdYs9verSsP3ozsVYS7iinnYoPX_wY7odwR6_c2w1FOwmavvcE_86G6ZKGOuNl9TWMrbxd.', 
    client_secret: '8612542553551939632',
    fields_mapping: {
      'name' => 'FirstName',
      'last_name' => 'LastName',
      'email' => 'Email',
      'company' => 'Company',
      'job_title' => 'Title',
      'phone' => 'Phone'
    }
  
end
