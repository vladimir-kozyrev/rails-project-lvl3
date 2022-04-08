# frozen_string_literal: true

class AdminPolicy
  attr_reader :user

  def initialize(user, _record)
    @user = user
  end

  def moderate?
    admin?
  end

  def index?
    admin?
  end

  def publish?
    admin?
  end

  def reject?
    admin?
  end

  def archive?
    admin?
  end

  private

  def admin?
    user&.admin?
  end
end
