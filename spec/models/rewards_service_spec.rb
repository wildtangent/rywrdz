require 'rails_helper'

describe RewardsService do
  let :rewards_service do
    RewardsService.new('234205435345', '3G100MB')
  end

  it 'should accept an account number' do
    expect(rewards_service.account_number).to eq '234205435345'
  end

  it 'should accept a tariff' do
    expect(rewards_service.tariff).to eq '3G100MB'
  end

  it 'should not return any rewards' do
    expect(rewards_service.rewards).to be_empty
  end
end
