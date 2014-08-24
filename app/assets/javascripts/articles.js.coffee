# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = () ->
  tagNames = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('name'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    prefetch: {
      url: '/tags.json',
      ttl: 0,
      filter: (list) -> $.map(list, (tagname) -> name: tagname);
    }
  });

  tagNames.initialize();

  $('#article_tags').tagsinput({
    typeaheadjs: {
      name: 'tagNames',
      displayKey: 'name',
      valueKey: 'name',
      source: tagNames.ttAdapter()
    }
  });

$(ready);
$(document).on('page:load', ready);

