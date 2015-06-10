require 'cucumber/rspec/doubles'

Given(/^I am on tariff (\S+)$/) do |tariff|
  account_number = '234567'
  @rewards_service = RewardsService.new(account_number, tariff)
end

Then(/^I should receive (\S+)$/) do |reward|
  expect_any_instance_of(EligibilityService)
    .to receive(:status).and_return 'CUSTOMER_ELIGIBLE'
  expect_any_instance_of(EligibilityService)
    .to receive(:valid?).and_return true

  expect(@rewards_service.rewards).to include reward
end

Then(/^I should not receive any rewards$/) do
  expect_any_instance_of(EligibilityService)
    .to receive(:status).and_return 'CUSTOMER_INELIGIBLE'
  expect_any_instance_of(EligibilityService)
    .to receive(:valid?).and_return true
  expect(@rewards_service.rewards).to be_empty
end

Given(/^there is an API error from the Eligibility Service$/) do
  double(
    EligibilityService,
    status: EligibilityService::EligibilityServiceError
  )
end

Given(/^I have supplied an invalid account number$/) do
  expect_any_instance_of(EligibilityService)
    .to receive(:valid?).and_return false
end

Then(/^I should be informed that my account number was invalid$/) do
  expect(@rewards_service.rewards).to be_empty
  expect(@rewards_service.errors).to include 'Account details are not valid'
end
