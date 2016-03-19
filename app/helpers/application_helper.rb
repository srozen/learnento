module ApplicationHelper

  def flash_success!(message)
    html = <<-HTML
    <div id="error_explanation" data-purpose="devise-alert" class="alert alert-success" role="alert">
      <ul>#{message}</ul>
    </div>
    HTML

    html.html_safe
  end
end
