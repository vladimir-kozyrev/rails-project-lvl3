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
    author?
  end

  private

  def author?
    record.user == user
  end

  def admin?
    user&.admin?
  end
end
