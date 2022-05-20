# frozen_string_literal: true

module Web::AdminHelper
  def admin_root_path_class
    'active' if current_page?(admin_root_path)
  end

  def admin_bulletins_path_class
    'active' if current_page?(admin_bulletins_path)
  end

  def admin_categories_path_class
    'active' if current_page?(admin_categories_path)
  end
end
