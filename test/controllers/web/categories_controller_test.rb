# frozen_string_literal: true

require 'test_helper'

class Web::CategoriesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    user = users(:admin)
    sign_in(user)
    get admin_categories_url
    assert_response :success
  end
end
