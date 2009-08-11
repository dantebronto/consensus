Feature: User CRUD
  As an user with administrative privileges
  In order to create and manage user accounts
  I want to leverage a basic user management system
    
  Scenario Outline: Allow access or not to user admin
    Given I am logged in <login>
    And I route to the <path>
    Then I should <see>
    Then I should <auth>
    
  Examples:
   | login       | path                       | see                         | auth                     |
   | as a user   | new_user_path              | not see "Create a new user" | see "Not authorized"     |
   | as an admin | new_user_path              | see "Create a new user"     | not see "Not authorized" |
   | as a user   | edit_user_path(User.first) | not see "Edit user"         | see "Not authorized"     |
   | as an admin | edit_user_path(User.first) | see "Edit user"             | not see "Not authorized" |
     
   Scenario Outline: Failed user creation
     Given I am logged in as an admin
     And there is a user with login "bob"
     And I route to the new_user_path
     And I fill in "login" with "<login>"
     And I fill in "email" with "<email>"
     And I fill in "password" with "<pass>"
     And I fill in "password confirmation" with "<pass-conf>"
     And I press "Create"
     Then I should <see>

     Examples:
      | login | email       | pass  | pass-conf | see                                       |
      | bob   | bob@bob.com | 12345 | 12345     | see "Login has already been taken"        |
      | bob   | bob@bob.com | 12345 | 12345     | see "Email has already been taken"        |
      | bob   | bob@bob.com |       | 12345     | see "Password doesn't match confirmation" |
      | bob   | bob@bob.com | 12345 |           | see "Password doesn't match confirmation" |
      |       | bob@bob.com | 12345 | 12345     | see "Login can't be blank"                |
      | bob   |             | 12345 | 12345     | see "Email can't be blank"                |

