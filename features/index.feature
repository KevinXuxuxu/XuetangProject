Feature: Index of the whole site

  As a visitor/tourist
  I want to see all kinds of news and information
  So that I can know things about Xuetang

Background: categories and their information are in the database

  Given the following categories exist:
  | name | description  | parent |
  | cat1 | for swears   |        |
  | cat2 | for songs    |        |
  | cat3 | for sub of 1 | cat1   |
  | cat4 | for sub of 2 | cat2   |
  | cat5 | for sub of 4 | cat4   |

  And I am on the index page

Scenario: show all the top categories
  When I am on the index page
  Then I should see the following things: cat1, cat2
  And I should not see the following things: cat3, cat4, cat5
  When I follow "cat1"
  Then I should be on the sub-category page of "cat1"