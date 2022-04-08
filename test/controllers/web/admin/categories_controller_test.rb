# frozen_string_literal: true

require 'test_helper'

class Web::Admin::CategoriesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    user = users(:admin)
    sign_in(user)
    get admin_categories_url
    assert_response :success
  end

  test 'should get new' do
    user = users(:admin)
    sign_in(user)
    get new_admin_category_url
    assert_response :success
  end

  test 'should get edit' do
    user = users(:admin)
    sign_in(user)
    category = categories(:work)
    get edit_admin_category_url(category)
    assert_response :success
  end

  test 'should create category' do
    user = users(:admin)
    sign_in(user)
    category_name = Faker::Lorem.sentence
    attrs = { name: category_name }
    post admin_categories_url, params: { category: attrs }
    assert_response :redirect
    assert { Category.find_by(name: category_name) }
  end

  test 'should update category' do
    user = users(:admin)
    sign_in(user)
    category = categories(:work)
    new_category_name = Faker::Lorem.sentence
    attrs = { name: new_category_name }
    put admin_category_url(category), params: { category: attrs }
    assert_response :redirect
    assert { Category.find_by(id: category.id) }
  end

  test 'should destroy unused category' do
    user = users(:admin)
    sign_in(user)
    category = categories(:unused)
    delete admin_category_url(category)
    assert_response :redirect
    assert { Category.find_by(id: category.id).nil? }
  end

  test 'should not destroy a category that has bulletins' do
    user = users(:admin)
    sign_in(user)
    category = categories(:life)
    delete admin_category_url(category)
    assert_response :redirect
    assert { Category.find_by(id: category.id) }
  end
end
