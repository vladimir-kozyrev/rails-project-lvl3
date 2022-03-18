# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'admin? should show whether the user is admin' do
    user = users(:regular_user)
    refute user.admin?
    user.admin = true
    user.save
    assert user.admin?
  end
end
