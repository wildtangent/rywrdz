class EligibilityService
  class EligibilityServiceError
  end

  attr_accessor :account_number

  def initialize(account_number)
    @account_number = account_number
  end

  def status
    # TODO: Requires API implementation from EligibilityService team
    # Probably some kind of Faraday interface
    'CUSTOMER_INELIGIBLE'
  end

  # TODO: Check account number for validity
  # TODO: Requires API implementation from EligibilityService team
  def valid?
    false
  end

  def errors
    @errors ||= []
  end
end
