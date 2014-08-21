Feature: manage articles efficiently

  As an administrator
  I want to see all articles
  So I can manage them

Background: articles and their information are in the database
  Given the following users exist:
  | name   |     stu_id |
  | JinSon | 2012012000 |
  | JuSon  | 2012012429 |
  | XuSon  | 2012012437 |
  Given the following categories exist:
  | name | description |
  | cat1 | for swears  |
  | cat2 | for songs   |
  Given the following articles exist:
  | title | content                        | category | author |
  | art1  | f*ck off                       | cat1     | JinSon |
  | art2  | F*ck off.                      | cat1     | JinSon |
  | art3  | Marry has a little lamb, ...   | cat1     | JuSon  |
  | art4  | Only you, can make all this... | cat2     | XuSon  |

  And I login as "XuSon"
  And I am on the article list page

Scenario: show all articles and informations
  When I am on the article list page
  Then I should see the following things: art1, JinSon, cat1
  And I should see the following things in order: art3, JuSon, cat1

Scenario: show specific article and it's detailed information
  When I am on the article list page
  Then I follow "Show" of "art3"
  Then I should be on the show page of article "art3"
  And I should see the following things: art3, cat1, JuSon
  And I should see "Marry has a little lamb, ..."

Scenario: enter edit page from show page and edit article
  When I am on the show page of article "art3"
  And I follow "Edit"
  Then I should be on the edit page of article "art3"
  And I should see "Marry has a little lamb, ..."
  Then I fill in "article_content" with "Wo yao fei de geng gao~~~"
  And I fill in "article_title" with "doubi"
  When I press "Submit"
  Then I should be on the show page of article "doubi"
  And I should see "Wo yao fei de geng gao~~~"
  And I should see "doubi"

Scenario: be able to get back to article list page
  When I am on the show page of article "art4"
  And I follow "Back"
  Then I should be on the article list page

Scenario: create new article
  When I am on the article list page
  And I follow "New Article"
  Then I should be on the create article page
  Then I fill in "article_title" with "the Lord of the Rings"
  And I fill in "article_content" with "Once upon a time, there was a little Hobbit..."
  And I select "cat2" from "article_category"
  And I press "Submit"
  Then I should be on the show page of article "the Lord of the Rings"
  And I should see the following things: cat2, XuSon
  And I should see "Once upon a time, there was a little Hobbit..."

Scenario: destroy article
  When I am on the article list page
  And I follow "Destroy" of "art4"
  Then I should be on the article list page
  And I should not see the following things: art4, XuSon, cat2
