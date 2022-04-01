# frozen_string_literal: true

class AdminPolicy
  attr_reader :user

  def initialize(user, _record)
    @user = user
  end

  def moderate?
    admin?
  end

  def bulletins?
    admin?
  end

  def approve?
    admin?
  end

  def reject?
    admin?
  end

  private

  def admin?
    user&.admin?
  end
end
