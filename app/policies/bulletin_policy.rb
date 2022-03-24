# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def create?
    user
  end

  def show?
    user
  end

  def update?
    admin? || author?
  end

  def admin_moderate?
    admin?
  end

  def admin_index?
    admin?
  end

  def profile?
    user
  end

  private

  def author?
    record.user == user
  end

  def admin?
    user&.admin?
  end
end
