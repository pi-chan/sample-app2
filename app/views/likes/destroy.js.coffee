$("#like-diary-<%= @diary.id %>").html("<%= j render partial: 'diaries/like', locals:{diary: @diary} %> ")

