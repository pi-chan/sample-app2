# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $(document).on "click", ".update-cart-product-button", (e)->
    $(@).parent().parent().find('form').submit()

$(document).ready(ready)
$(document).on('page:load', ready)
