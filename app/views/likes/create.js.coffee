$("#like-diary-<%= @diary.id %>").html("<%= j render partial: 'diaries/dislike', locals:{diary: @diary} %> ")
