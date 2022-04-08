# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    user
  end

  def show?
    published?
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

  def published?
    record.published?
  end
end
