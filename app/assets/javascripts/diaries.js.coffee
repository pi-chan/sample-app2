# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  submitting = false
  m = document.location.pathname.match("/users/(.+)/diaries")
  $user_id = m[1]

  insert_string_at_caret = (target, str)->
    obj = $(target)
    obj.focus()
    if navigator.userAgent.match(/MSIE/)
      r = document.selection.createRange()
      r.text = str
      r.select()
    else
      s = obj.val()
      p = obj.get(0).selectionStart
      np = p + str.length
      obj.val(s.substr(0, p) + str + s.substr(p))
      obj.get(0).setSelectionRange(np, np)
  
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

  $(document).bind "dragover", (e)->
    $dropzone = $("#dropzone")
    $form = $("#diary-form")
    $dropzone.height($form.height())
    $dropzone.css
      "top":$form.offset().top
      
    $dropzone.show()
    console.log e.type
    e.preventDefault()

  $(document).bind "drop dragleave", (e)->
    $dropzone = $("#dropzone")
    $dropzone.hide()
    console.log e.type
    e.preventDefault()

$(document).ready(ready)
$(document).on('page:load', ready)
