# frozen_string_literal: true

module Web::AdminHelper
  def admin_nav_link_classes(page_path)
    common_classes = 'nav-link link-dark'
    return "#{common_classes} active" if current_page?(page_path)

    common_classes
  end
end
