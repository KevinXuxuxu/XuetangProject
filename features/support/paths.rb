# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    # when /^the (RottenPotatoes )?home\s?page$/ then '/movies'
    # when /^the movies page$/ then '/movies'

    # user
    when /^the user list page/ then '/users'
    # article
    when /^the article list page/ then '/articles'
    when /^the show page of article "(.*)"/ then "/articles/#{Article.find_by_title($1).id}"
    when /^the edit page of article "(.*)"/ then "/articles/#{Article.find_by_title($1).id}/edit"
    when /^the create article page/ then '/articles/new'
    # category
    when /^the category list page/ then '/categories'
    when /^the create category page/ then '/categories/new'
    when /^the sub-category page of "(.*)"/ then "/categories/#{Category.find_by_name($1).id}"
    when /^the edit page of category "(.*)"/ then "/categories/#{Category.find_by_name($1).id}/edit"
    # index
    when /^the index page/ then "/"

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
