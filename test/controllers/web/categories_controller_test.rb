# frozen_string_literal: true

require 'test_helper'

class Web::CategoriesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get admin_categories_url
    assert_response :success
  end

  # test 'should get new' do
  #   get new_admin_category
  #   assert_response :success
  # end

  # test 'should get create' do
  #   get web_categories_create_url
  #   assert_response :success
  # end

  # test 'should get edit' do
  #   get web_categories_edit_url
  #   assert_response :success
  # end

  # test 'should get destroy' do
  #   get web_categories_destroy_url
  #   assert_response :success
  # end
end
