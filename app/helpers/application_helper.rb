module ApplicationHelper
  def sidebar_link_active?(link_name)
    controller_name == link_name
  end
end
