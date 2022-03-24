# frozen_string_literal: true

require 'test_helper'

class Web::BulletinsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    user = users(:regular_user)
    sign_in(user)
    get bulletins_url
    assert_response :success
  end

  test 'should get show' do
    user = users(:regular_user)
    sign_in(user)
    bulletin = bulletins(:draft)
    get bulletin_url(bulletin)
    assert_response :success
  end

  test 'should get new' do
    user = users(:regular_user)
    sign_in(user)
    get new_bulletin_url
    assert_response :success
  end

  test 'should create bulletin' do
    user = users(:regular_user)
    sign_in(user)
    category = categories(:work)
    bulletin_title = Faker::Lorem.sentence
    bulletin_description = Faker::Lorem.paragraphs.join("\n")
    attrs = {
      title: bulletin_title,
      description: bulletin_description,
      category_id: category.id,
      user_id: user.id
    }
    post bulletins_url, params: { bulletin: attrs }
    assert_response :redirect
    assert { Bulletin.find_by(title: bulletin_title) }
  end

  test 'should get edit' do
    user = users(:regular_user)
    sign_in(user)
    bulletin = bulletins(:draft)
    get edit_bulletin_url(bulletin)
    assert_response :success
  end

  test 'should update bulletin' do
    user = users(:regular_user)
    sign_in(user)
    bulletin = bulletins(:draft)
    new_bulletin_title = Faker::Lorem.sentence
    attrs = {
      title: new_bulletin_title,
      description: bulletin.description,
      category_id: bulletin.category_id,
      user_id: bulletin.user_id
    }
    put bulletin_url(bulletin), params: { bulletin: attrs }
    assert_response :redirect
    assert { Bulletin.find_by(title: new_bulletin_title) }
  end

  test 'to_moderate changes state to under_moderation' do
    user = users(:regular_user)
    sign_in(user)
    bulletin = bulletins(:draft)
    assert bulletin.draft?
    patch to_moderate_bulletin_url(bulletin)
    assert_response :redirect
    assert { Bulletin.where(id: bulletin.id).first.under_moderation? }
  end

  test 'archive changes state to archived' do
    user = users(:regular_user)
    sign_in(user)
    bulletin = bulletins(:draft)
    refute bulletin.archived?
    patch archive_bulletin_url(bulletin)
    assert_response :redirect
    assert { Bulletin.where(id: bulletin.id).first.archived? }
  end

  test 'publish changes state to published' do
    user = users(:admin)
    sign_in(user)
    bulletin = bulletins(:under_moderation)
    assert bulletin.under_moderation?
    patch admin_publish_url(bulletin)
    assert_response :redirect
    assert { Bulletin.where(id: bulletin.id).first.published? }
  end

  test 'reject changes state to rejected' do
    user = users(:admin)
    sign_in(user)
    bulletin = bulletins(:under_moderation)
    assert bulletin.under_moderation?
    patch admin_reject_url(bulletin)
    assert_response :redirect
    assert { Bulletin.where(id: bulletin.id).first.rejected? }
  end
end
