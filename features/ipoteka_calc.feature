Feature: Ipoteka calc
  Testing correct work of "https://calcus.ru/kalkulyator-ipoteki"

  Scenario: Checking correctness of calculations
    Given Opened page
    When Input parameters: <cost>, <start_sum>, <period>
    Then Check payment

  Examples:
    | cost    | start_sum | period |
    | 12000000| 20        | 20     |
