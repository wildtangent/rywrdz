class RewardsService
  class InvalidAccountNumberError < StandardError
  end

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
      when 'CUSTOMER_ELIGIBLE'
        rewards = RewardLookup.find(@tariff)
      else
        errors << 'Account details are not valid'
      end
    end
    rewards
  end

  def errors
    @errors ||= []
  end

  private

  def eligibility_service
    @eligibility_service ||= EligibilityService.new(@account_number)
  end

  # Request elgibility status from the Eligiblity Service API
  def check_eligibility
    eligibility_service.status
  end

  def check_validity
    eligibility_service.valid?
  end
end
