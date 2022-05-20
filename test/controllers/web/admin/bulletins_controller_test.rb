# frozen_string_literal: true

require 'test_helper'

class Web::Admin::BulletinsControllerTest < ActionDispatch::IntegrationTest
  def setup
    admin = users(:admin)
    sign_in(admin)
  end

  test 'regular user cannot access admin bulletins endpoints' do
    user = users(:regular_user)
    sign_in(user)
    bulletin = bulletins(:published)
    get admin_root_url
    assert_response :redirect
    get admin_bulletins_url
    assert_response :redirect
    patch reject_admin_bulletin_url(bulletin)
    assert_response :redirect
  end

  test 'should get bulletins under moderation' do
    get admin_root_url
    assert_response :success
  end

  test 'should get all bulletins' do
    get admin_bulletins_url
    assert_response :success
  end

  test 'publish changes state to published' do
    bulletin = bulletins(:under_moderation)
    assert bulletin.under_moderation?
    patch publish_admin_bulletin_url(bulletin)
    assert_response :redirect
    assert { Bulletin.where(id: bulletin.id).first.published? }
  end

  test 'reject changes state to rejected' do
    bulletin = bulletins(:under_moderation)
    assert bulletin.under_moderation?
    patch reject_admin_bulletin_url(bulletin)
    assert_response :redirect
    assert { Bulletin.where(id: bulletin.id).first.rejected? }
  end

  test 'archive changes state to archived' do
    bulletin = bulletins(:under_moderation)
    assert bulletin.under_moderation?
    patch archive_admin_bulletin_url(bulletin)
    assert_response :redirect
    assert { Bulletin.where(id: bulletin.id).first.archived? }
  end
end
