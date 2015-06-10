require 'cucumber/rspec/doubles'

Given(/^I am on tariff (\S+)$/) do |tariff|
  account_number = '234567'
  @rewards_service = RewardsService.new(account_number, tariff)
end

Given(/^I am eligible for rewards/) do
  es = instance_double(
    EligibilityService,
    status: 'CUSTOMER_ELIGIBLE',
    valid?: true
  )
  allow(@rewards_service).to receive(:eligibility_service).and_return es
end

Given(/^I am not eligible for rewards$/) do
  es = instance_double(
    'EligibilityService',
    status: 'CUSTOMER_INELIGIBLE',
    valid?: true
  )
  allow(@rewards_service).to receive(:eligibility_service).and_return es
end

Given(/^there is an API error from the Eligibility Service$/) do
  es = instance_double(
    'EligibilityService',
    status: -> { fail EligibilityService::EligibilityServiceError },
    valid?: true
  )
  allow(@rewards_service).to receive(:eligibility_service).and_return es
end

Given(/^I have supplied an invalid account number$/) do
  es = instance_double(
    'EligibilityService',
    status: 'CUSTOMER_INELIGIBLE',
    valid?: false
  )
  allow(@rewards_service).to receive(:eligibility_service).and_return es
end

Then(/^I should receive (\S+)$/) do |reward|
  expect(@rewards_service.rewards).to include reward
end

Then(/^I should not receive any rewards$/) do
  expect(@rewards_service.rewards).to be_empty
end

Then(/^I should be informed that my account number was invalid$/) do
  expect(@rewards_service.errors).to include 'Account details are not valid'
end

Then(/^I should not receive any error messages$/) do
  expect(@rewards_service.errors).to be_empty
end
