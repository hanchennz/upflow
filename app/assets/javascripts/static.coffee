$(document).ready ->
  $('#learn-more a').click (event) ->
    $('html, body').animate(
      scrollTop: $('#story-section').offset().top
    , 500)

  $('#about-link').click (event) ->
    $('html, body').animate(
      scrollTop: $('#about').offset().top
    , 500)

  $('#back-to-top').click (event) ->
    $('html, body').animate(
      scrollTop: $('#log-in').offset().top
    , 500)
