module CommentsHelper

  def render_child_comments(comment)
    html = ""
    comment.child_comments.each do |child_comment|
      html += "<br>"
      html += child_comment.content
      html += render_child_comments(child_comment)
    end
    html.html_safe
  end
end
