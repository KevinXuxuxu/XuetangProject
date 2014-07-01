Feature: display all categories and information

  As an administrator
  I want to see all categories
  So I can manage them

Background: categories and their information are in the database
  
  Given the following categories exist:
  | name | description  | parent |
  | cat1 | for swears   |        |
  | cat2 | for songs    | cat1   |
  | cat3 | for sub of 2 | cat2   |
  | cat4 | for sub of 2 | cat2   |
  | cat5 | for sub of 3 | cat4   |
  
  And I am on the category list page

Scenario: show all categories and their information
  When I am on the category list page
  Then I should see the following things in order: cat1, for swears, N/A
  And I should see the following things in order: cat2, for songs, cat1
  And I should see the following things in order: cat4, for sub of 2, cat2
