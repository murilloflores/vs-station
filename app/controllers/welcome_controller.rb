class WelcomeController < ApplicationController

	skip_before_action :authenticate_client!

	def welcome

		if client_signed_in?
			redirect_to campaigns_path
		end

	end

end