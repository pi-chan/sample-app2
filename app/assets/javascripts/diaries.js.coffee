# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  submitting = false
  match = document.location.pathname.match("/users/(.+)/diaries")
  $user_id = match[1]

  insert_string_at_caret = (textarea, inserting_string)->
    textarea.focus()
    if navigator.userAgent.match(/MSIE/)
      range = document.selection.createRange()
      range.text = inserting_string
      range.select()
    else
      original_text = textarea.val()
      position = textarea.get(0).selectionStart
      new_position = position + inserting_string.length
      new_text = original_text.substr(0, position) + inserting_string + original_text.substr(position)
      textarea.val(new_text)
      textarea.get(0).setSelectionRange(new_position, new_position)

  show_dropzone = (e)->
    $dropzone = $("#dropzone")
    $form = $("#diary-form")
    $dropzone.height($form.height())
    $dropzone.css
      "top":$form.offset().top
    $dropzone.show()
    e.preventDefault()

  hide_dropzone = (e)->
    $dropzone = $("#dropzone")
    $dropzone.hide()
    e.preventDefault()
  
  $("#diary-form").fileupload 
    url: "/users/" + $user_id + "/diary_images"
    type: 'POST'
    dataType: "json"
    dropZone: $("body")
    done: (e, data)->
      insert_string_at_caret($("#diary_body"), data.result.tag)
    fail: (e, data)->
      alert("アップロードに失敗しました")

  $(document).on "click", "#diary-image-submit", (e)->
    $("#diary-image-file").click() unless submitting
    return false

  $(document).on "change", "#diary-image-file", (e)->
    $(@).closest("form").submit()
    submitting = true

  $("#diary-image-form").bind 'ajax:complete', (e, data)->
    submitting = false
    tag = JSON.parse(data.responseText).tag
    insert_string_at_caret($("#diary_body"), tag)

  $(document).bind "dragover", show_dropzone
  $(document).bind "drop dragleave", hide_dropzone

$(document).ready(ready)
$(document).on('page:load', ready)
