Feature: manage categories and their information

  As an administrator
  I want to see all categories
  So I can manage them

Background: categories and their information are in the database

  Given the following users exist:
  | name   |     stu_id |
  | JinSon | 2012012000 |
  | JuSon  | 2012012429 |
  | XuSon  | 2012012437 |
  Given the following categories exist:
  | name | description  | parent |
  | cat1 | for swears   |        |
  | cat2 | for songs    |        |
  | cat3 | for sub of 1 | cat1   |
  | cat4 | for sub of 2 | cat2   |
  | cat5 | for sub of 4 | cat4   |
  Given the following articles exist:
  | title | content                        | category | author |
  | art1  | f*ck off                       | cat1     | JinSon |
  | art2  | F*ck off.                      | cat1     | JinSon |
  | art3  | Marry has a little lamb, ...   | cat2     | JuSon  |
  | art4  | Only you, can make all this... | cat2     | XuSon  |

  And I am on the category list page

Scenario: show top categories and their information
  When I am on the category list page
  Then I should see the following things in order: cat1, for swears, N/A
  And I should see the following things in order: cat2, for songs, N/A
  And I should not see the following things: cat4, for sub of 2

Scenario: create new category
  When I am on the category list page
  And I follow "New Category"
  Then I should be on the create category page
  Then I fill in "category_name" with "cat6"
  And I fill in "category_description" with "this is a new category!!"
  And I select "cat2" from "category_parent"
  Then I press "Submit"
  Then I should be on the sub-category page of "cat6"
  When I am on the sub-category page of "cat2"
  And I should see the following things in order: cat6, this is a new category!!, cat2

Scenario: show sub category
  When I am on the category list page
  And I follow "show" of "cat2"
  Then I should be on the sub-category page of "cat2"
  And I should see the following things in order: cat4, for sub of 2, cat2
  When I follow "show" of "cat4"
  Then I should be on the sub-category page of "cat4"
  And I should see the following things in order: cat5, for sub of 4, cat4

Scenario: edit category
  When I am on the category list page
  And I follow "edit" of "cat2"
  Then I should be on the edit page of category "cat2"
  Then I fill in "category_name" with "new_name"
  And I fill in "category_description" with "new whatever bolocks..."
  And I select "cat3" from "category_parent"
  And I press "Submit"
  Then I should be on the sub-category page of "new_name"
  When I am on the sub-category page of "cat3"
  And I should see the following things in order: new_name, new whatever bolocks..., cat3

Scenario: destroy category
  When I am on the category list page
  And I follow "destroy" of "cat2"
  Then I should be on the category list page
  And I should not see "cat2"