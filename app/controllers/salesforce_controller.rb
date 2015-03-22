class SalesforceController < ApplicationController

  before_action :set_lead

  def send_to_salesforce

    begin
      @lead.save_on_salesfoce!(current_client)
      redirect_to campaign_path(@lead.campaign)
    rescue Exception => e
      #TODO improve error treatment in here
      redirect_to campaign_path(@lead.campaign), notice: "Could not sync to salesforce: "+e.message 
    end

  end


  def remove_from_salesforce

    begin
      @lead.remove_from_salesforce!(current_client)
      redirect_to campaign_path(@lead.campaign)
    rescue Exception => e
      #TODO improve error treatment in here
      redirect_to campaign_path(@lead.campaign), notice: "Could not delete lead from salesforce: "+e.message 
    end

  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_lead
      @lead = Lead.find(params[:lead_id])
    end
  

end