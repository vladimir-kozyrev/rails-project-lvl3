# frozen_string_literal: true

require 'test_helper'

class Web::Admin::CategoriesControllerTest < ActionDispatch::IntegrationTest
  def setup
    user = users(:admin)
    sign_in(user)
  end

  test 'regular user cannot access admin categories endpoints' do
    user = users(:regular_user)
    sign_in(user)
    category = categories(:work)
    get admin_categories_url
    assert_response :redirect
    post admin_categories_url, params: { category: { name: Faker::Lorem.sentence } }
    assert_response :redirect
    get new_admin_category_url
    assert_response :redirect
    get edit_admin_category_url(category)
    assert_response :redirect
    patch admin_category_url(category), params: { category: { name: Faker::Lorem.sentence } }
    assert_response :redirect
    delete admin_category_url(category)
    assert_response :redirect
  end

  test 'should get index' do
    get admin_categories_url
    assert_response :success
  end

  test 'should get new' do
    get new_admin_category_url
    assert_response :success
  end

  test 'should get edit' do
    category = categories(:work)
    get edit_admin_category_url(category)
    assert_response :success
  end

  test 'should create category' do
    category_name = Faker::Lorem.sentence
    attrs = { name: category_name }
    post admin_categories_url, params: { category: attrs }
    assert_response :redirect
    assert { Category.find_by(name: category_name) }
  end

  test 'should update category' do
    category = categories(:work)
    new_category_name = Faker::Lorem.sentence
    attrs = { name: new_category_name }
    put admin_category_url(category), params: { category: attrs }
    assert_response :redirect
    assert { Category.find_by(name: new_category_name) }
  end

  test 'should destroy unused category' do
    category = categories(:unused)
    delete admin_category_url(category)
    assert_response :redirect
    assert { Category.find_by(id: category.id).nil? }
  end

  test 'should not destroy a category that has bulletins' do
    category = categories(:life)
    delete admin_category_url(category)
    assert_response :redirect
    assert { Category.find_by(id: category.id) }
  end
end
