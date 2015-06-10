# Class to look up the approprate rewards by customer account number
# and tariff
class RewardsService
  attr_reader :account_number, :tariff

  # Accepts account_number and tariff
  def initialize(account_number, tariff)
    @account_number = account_number
    @tariff = tariff
  end

  # Return which rewards are available to the user
  def rewards
    rewards = []
    if check_validity
      case check_eligibility
      when EligibilityService::CUSTOMER_ELIGIBLE
        rewards = RewardLookup.find(@tariff)
      end
    else
      errors << 'Account details are not valid'
    end
    rewards
  end

  # Errors to return to the user
  def errors
    @errors ||= []
  end

  private

  # Instanciate the EligibilityService class using the customer's account number
  def eligibility_service
    @eligibility_service ||= EligibilityService.new(@account_number)
  end

  # Request elgibility status from the EligiblityService API
  def check_eligibility
    eligibility_service.status
  end

  # Check if the eligibility service considers the supplied
  # credentials to be valid
  def check_validity
    eligibility_service.valid?
  end
end
