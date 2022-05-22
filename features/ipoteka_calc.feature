Feature: Ipoteka calc
  Testing correct work of "https://calcus.ru/kalkulyator-ipoteki"

  Scenario: Checking correctness of calculations
    Given Opened page
    When Input parameters
    Then Check payment
