# Stub class to handle requests to the Eligibility Service API
# which has not yet been built
class EligibilityService
  # Error to raise if the service backend returns an error
  class EligibilityServiceError < StandardError
  end

  CUSTOMER_ELIGIBLE = 'CUSTOMER_ELIGIBLE'
  CUSTOMER_INELIGIBLE = 'CUSTOMER_INELIGIBLE'

  attr_accessor :account_number

  # Initialize class providing the customer account number
  def initialize(account_number)
    @account_number = account_number
  end

  # TODO: Requires API implementation from EligibilityService team
  # Probably some kind of Faraday interface
  def status
    CUSTOMER_INELIGIBLE
  end

  # TODO: Check account number for validity
  # TODO: Requires API implementation from EligibilityService team
  def valid?
    false
  end
end
