Feature: Basic Voting Flows
  As a member with an opinion
  In order to make my preference known
  I want to be able to vote and view voting results
  
  Scenario: Vote create fail, not enough options
    Given I am logged in as a user
    And I follow "votes"
    Then I should see "Current Votes"
    
    And I follow "New vote"
    Then I should see "Create a vote"
    
    And I fill in "name" with "vote name"
    And I press "Create"
    Then I should see "must have at least two topics on which to vote"
    
  Scenario: Vote create fail, missing name
    Given I am logged in as a user
    And I follow "votes"
    Then I should see "Current Votes"

    And I follow "New vote"
    Then I should see "Create a vote"

    And I fill in "name" with ""
    And I press "Create"
    Then I should see "Name can't be blank"
    
  Scenario: Casting, Single-Option
    Given I am logged in as a user
    And a vote exists with three options
    And I route to the cast_vote_path(Vote.first)
    Then I should see "Options"