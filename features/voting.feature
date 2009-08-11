Feature: Basic Voting Flows
  As a member with an opinion
  In order to make my preference known
  I want to be able to vote and view voting results
  
  Scenario: Vote create
    Given I am logged in as a user
    And I follow "Active votes"
    Then I should see "Current Votes"
    
    And I follow "New vote"
    Then I should see "Create a vote"
    
    And I fill in "name" with "vote name"
    And I press "Create"
    Then I should see "Vote was successfully created"
    
  Scenario: Vote create fail
    Given I am logged in as a user
    And I follow "Active votes"
    Then I should see "Current Votes"

    And I follow "New vote"
    Then I should see "Create a vote"

    And I fill in "name" with ""
    And I press "Create"
    Then I should see "Name can't be blank"
    
    