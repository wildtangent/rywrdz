Feature: Display customer's available rewards
  As a customer
  Given I am eligible for rewards
  Then I want to see which rewards are available based on my tariff and loyalty.

  Scenario Outline: Customer is eligible for rewards
    As a customer
    Given I am on tariff <tariff>
    Then I should receive <reward>

    Examples:
      | tariff   | reward      |
      | 3G100MB  | EXTRA50MB   |
      | 3G250MB  | EXTRA100MB  |
      | 3G500MB  | EXTRA250MB  |
      | 3G1000MB | EXTRA500MB  |
      | 3G2000MB | EXTRA1000MB |

  Scenario Outline: Customer is not eligible for rewards
    As a customer
    Given I am on tariff <tariff>
    Then I should not receive any rewards

    Examples:
      | tariff      |
      | O2BeMoreDog |
      | ThreeAtHome |
      | 4G100MB     |


  Scenario: Eligibility Service returns a technical failure
    As a customer
    Given I am on tariff 3G1000MB
    And there is an API error from the Eligibility Service
    Then I should not receive any rewards

  Scenario: Invalid account number supplied
    As a customer
    Given I have supplied an invalid account number
    Then I should not receive any rewards
    And I should be informed that my account number was invalid
