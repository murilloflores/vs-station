# vs-station
Very Simple Station is a rails app designed to demonstrate how to use the [salesforceable](https://github.com/murilloflores/salesforceable) ruby gem.
You will be specialy interested in the [Lead Model](app/models/lead.rb) and in the [Salesforce Controller](app/controllers/salesforce_controller.rb)

## Prerequisites
In order to run the app you must have ruby 2.2 and rails 4.2.1.

## Live
You can access a running copy of the app at [https://vsstation.herokuapp.com/](https://vsstation.herokuapp.com/).
After creating an account you can create campaigns and then collect leads with a predefined form. This collected leads can then be sent to salesforce.
In order to send Leads to salesforce you have to link your salesforce account to your vs-station account. You can do so by clicking in the 'Linked Services' link on the upper right corner, after logging in. Once your Salesforce account is linked you can send collected leads individually or create a Campaign that automatically syncs with Salesforce.
