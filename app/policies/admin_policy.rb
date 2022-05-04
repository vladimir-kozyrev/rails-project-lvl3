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

  def show?
    admin?
  end

  def new?
    create?
  end

  def create?
    admin?
  end

  def edit?
    update?
  end

  def update?
    admin?
  end

  def destroy?
    admin?
  end

  private

  def admin?
    user&.admin?
  end
end
