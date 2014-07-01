$("#like-diary-<%= @diary.id %>").html("<%= j render partial: 'diaries/dislike', locals:{diary: @diary} %> ")
$("#like-count-diary-<%= @diary.id %>").html("<%= j render partial: 'diaries/like_count', locals:{diary: @diary} %> ")
