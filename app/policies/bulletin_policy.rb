# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def create?
    user
  end

  def moderate?
    user&.admin?
  end

  def admin_index?
    user&.admin?
  end

  def profile?
    user
  end
end
