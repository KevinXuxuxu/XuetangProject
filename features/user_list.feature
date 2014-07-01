Feature: display all users and their corresponding information

  As an administrator
  I want to see all users
  So I can have their informations

Background: users and their information are in the database
  Given the following users exist:
  | name   |     stu_id |
  | JinSon | 2012012000 |
  | JuSon  | 2012012429 |
  | XuSon  | 2012012437 |

  And I am on the user list page

Scenario: show all users and their corresponding information
  When I am on the user list page
  Then I should see JinSon before 2012012000
  And I should see JuSon before 2012012429
  And I should see XuSon before 2012012437
