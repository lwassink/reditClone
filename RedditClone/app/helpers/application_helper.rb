module ApplicationHelper
  def errors
    if flash[:errors]
      html = "<ul>"
      flash[:errors].each do |error|
        html += "<li>#{error}</li>"
      end
      html += "</ul>"
      html.html_safe
    end
  end

  def auth_token
    '<input name="authenticity_token" value="<%= form_authenticity_token %>" type="hidden">'.html_safe
  end
end
