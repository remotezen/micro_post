module ApplicationHelper
  def full_title(title)
    unless title.blank?
      title += " | Micropost Application"
    else
      title = "Micropost Application"
    end
  end
end
