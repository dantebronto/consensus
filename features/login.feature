Feature: User login/logout
  As a user of the system
  In order to follow the contributions of other users
  I want to allow users to login and maintain sessions

  Scenario: User logs in
    Given there is a User whose login is "kellen"
    And I go to the homepage
    And I follow "login"
    And I fill in "login" with "kellen"
    And I fill in "password" with "p455wd!"
    And I press "Login"
    Then I should see "Logged in"
  
  Scenario: Non-registered user attempts login
    Given there is not a User whose login is "betelgeuse"
    And I go to the homepage
    And I follow "login"
    And I fill in "login" with "betelgeuse"
    And I fill in "password" with "p455wd!"
    And I press "Login"
    Then I should see "Unknown login or password"
  
  Scenario: User logout
    Given I am logged in as a user
    And I go to the homepage
    Then I should see "Logout"
    When I follow "logout"
    Then I should see "You have been logged out"
    And I should see "Login"