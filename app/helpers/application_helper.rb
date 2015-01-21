module ApplicationHelper
  def form_group_tag(errors)
    error.to_s if errors.any?
  end
end
