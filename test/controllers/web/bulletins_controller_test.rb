# frozen_string_literal: true

require 'test_helper'

class Web::BulletinsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:regular_user)
    sign_in(@user)
  end

  test 'should get index' do
    get bulletins_url
    assert_response :success
  end

  test 'should get show' do
    bulletin = bulletins(:published)
    get bulletin_url(bulletin)
    assert_response :success
  end

  test 'should not show unpublished bulletins' do
    sign_out
    bulletin = bulletins(:draft)
    get bulletin_url(bulletin)
    assert_response :redirect
  end

  test 'should get new' do
    get new_bulletin_url
    assert_response :success
  end

  test 'should create bulletin' do
    category = categories(:work)
    bulletin_title = Faker::Lorem.sentence
    bulletin_description = Faker::Lorem.paragraphs.join("\n")
    attrs = {
      title: bulletin_title,
      description: bulletin_description,
      category_id: category.id,
      user_id: @user.id,
      image: fixture_file_upload(Rails.root.join('public/images/bananas.jpeg'), 'image/jpeg')
    }
    post bulletins_url, params: { bulletin: attrs }
    assert_response :redirect
    assert { Bulletin.find_by(title: bulletin_title) }
  end

  test 'should get edit' do
    bulletin = bulletins(:draft)
    get edit_bulletin_url(bulletin)
    assert_response :success
  end

  test 'should update bulletin' do
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
    bulletin = bulletins(:draft)
    assert bulletin.draft?
    patch to_moderate_bulletin_url(bulletin)
    assert_response :redirect
    assert { Bulletin.where(id: bulletin.id).first.under_moderation? }
  end

  test 'archive changes state to archived' do
    bulletin = bulletins(:draft)
    assert_not bulletin.archived?
    patch archive_bulletin_url(bulletin)
    assert_response :redirect
    assert { Bulletin.where(id: bulletin.id).first.archived? }
  end
end
