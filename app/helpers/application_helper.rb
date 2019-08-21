module ApplicationHelper
  def excerpt_comment(comment)
    if comment.length > 100
      comment = "#{comment.slice(0, 100)}・・・"
    end
    comment
  end
end
