module ApplicationHelper
  def full_title(title="")
    unless title.blank?
      title += " | Micropost Application"
    else
      title = "Micropost Application"
    end
  end
  def __debug__(str)
    raise "\t\t\t\n\n\n###################\n\t\t\t HERE IS THE VALUE\t" + str.inspect + "\n####################"
  end
end
