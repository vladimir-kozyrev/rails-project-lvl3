# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def create?
    user
  end

  def show?
    user
  end

  def update?
    author?
  end

  def profile?
    user
  end

  def to_moderate?
    author?
  end

  def archive?
    admin? || author?
  end

  def admin_moderate?
    admin?
  end

  def admin_index?
    admin?
  end

  def admin_publish?
    admin?
  end

  def admin_reject?
    admin?
  end

  private

  def author?
    record.user == user
  end

  def admin?
    user&.admin?
  end
end
