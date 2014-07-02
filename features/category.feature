Feature: manage categories and their information

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

Scenario: create new category
  When I am on the category list page
  And I follow "New Category"
  Then I should be on the create category page
  Then I fill in "name" with "cat5"
  And I fill in "description" with "this is a new category!!"
  And I fill in "parent" with "cat2"
  Then I press "Submit"
  Then I should be on the category list page
  And I should see the following things in order: cat5, this is a new category!!, cat2