require 'rails_helper'

describe EligibilityService do
  let :eligibility_service do
    EligibilityService.new('23523534')
  end

  it 'should set the account number' do
    expect(eligibility_service.account_number).to eq '23523534'
  end

  it 'should return the CUSTOMER_INELIGIBLE response by default' do
    expect(eligibility_service.status).to eq 'CUSTOMER_INELIGIBLE'
  end

  it 'should not validate the account_number by default' do
    expect(eligibility_service.valid?).to be false
  end
end
