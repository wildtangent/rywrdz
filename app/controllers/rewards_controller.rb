class RewardsController < ApplicationController
  # Display rewards based on user's input credentials
  def index
    @account_number = params[:account_number]
    @tariff = params[:tariff]
    @rewards_service = RewardsService.new(@account_number, @tariff)
    respond_to do |format|
      format.json {}
    end
  end
end
