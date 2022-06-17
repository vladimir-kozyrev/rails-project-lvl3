# frozen_string_literal: true

require 'test_helper'

class Web::Admin::HomeControllerTest < ActionDispatch::IntegrationTest
  def setup
    admin = users(:admin)
    sign_in(admin)
  end

  test 'regular user cannot access /admin' do
    sign_in_as_regular_user
    get admin_root_url
    assert_response :redirect, message: 'You are not authorized to perform this action'
  end

  test 'should get bulletins under moderation' do
    get admin_root_url
    assert_response :success
  end
end
