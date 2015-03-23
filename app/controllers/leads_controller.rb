class LeadsController < ApplicationController
  before_action :set_lead, only: [:show, :edit, :update, :destroy]
  before_action :set_campaign, only: [:index, :create, :new, :show, :edit, :update, :destroy]
  skip_before_action :authenticate_client!, only: [:new, :create, :thanks]
  after_action :sync_with_salesforce, only: [:create]

  layout :application_layout

  layout 'external', only: ['new', 'thanks']

  # GET /leads
  # GET /leads.json
  def index
    @leads = Lead.all()
  end

  # GET /leads/1
  # GET /leads/1.json
  def show
  end

  # GET /leads/new
  def new
    @lead = Lead.new
    @lead.campaign = @campaign
  end

  # GET /leads/1/edit
  def edit
  end

  # GET /leads/thanks
  def thanks
  end

  # POST /leads
  # POST /leads.json
  def create
    @lead = Lead.new(lead_params)
    @lead.campaign_id = @campaign.id

    respond_to do |format|
      if @lead.save
        format.html { redirect_to thanks_path, notice: 'Your subscription has been successfully completed.' }
        format.json { render :show, status: :created, location: @lead }
      else
        format.html { render :new }
        format.json { render json: @lead.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /leads/1
  # PATCH/PUT /leads/1.json
  def update
    #TODO implement the update at salesforce
    respond_to do |format|
      if @lead.update(lead_params)
        format.html { redirect_to campaign_lead_url(@campaign, @lead), notice: 'Lead was successfully updated.' }
        format.json { render :show, status: :ok, location: @lead }
      else
        format.html { render :edit }
        format.json { render json: @lead.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leads/1
  # DELETE /leads/1.json
  def destroy
    @lead.destroy
    respond_to do |format|
      format.html { redirect_to campaign_url(@campaign), notice: 'Lead was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lead
      @lead = Lead.find(params[:id])
    end

    def set_campaign
      @campaign = Campaign.find(params[:campaign_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lead_params
      params.require(:lead).permit(:name, :last_name, :email, :company, :job_title, :phone, :website, :campaign_id)
    end

    def application_layout
      client_signed_in? ? "application" : "external"
    end

    def sync_with_salesforce
      if @campaign.sync_with_salesforce?
        begin
          #TODO improve error treatment in here
          @lead.save_on_salesforce!(@campaign.client.refresh_token, @campaign.client.instance_url)
        rescue Exception => e
          puts e.message
        end
      end
    end

end
