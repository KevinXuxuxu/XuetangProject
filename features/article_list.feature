Feature: display all articles and information
  
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
  | art3  | Marry has a little lamb, ...   | cat2     | JuSon  |
  | art4  | Only you, can make all this... | cat2     | XuSon  |

  And I am on the article list page

Scenario: show all articles and informations
  When I am on the article list page
  Then I should see "art1"
