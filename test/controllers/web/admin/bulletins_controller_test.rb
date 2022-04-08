# frozen_string_literal: true

require 'test_helper'

class Web::Admin::BulletinsControllerTest < ActionDispatch::IntegrationTest
  test 'regular user cannot get bulletins under moderation' do
    user = users(:regular_user)
    sign_in(user)
    assert_raises(Pundit::NotAuthorizedError) { get admin_root_url }
  end

  test 'should get bulletins under moderation' do
    admin = users(:admin)
    sign_in(admin)
    get admin_root_url
    assert_response :success
  end

  test 'should get all bulletins' do
    admin = users(:admin)
    sign_in(admin)
    get admin_bulletins_url
    assert_response :success
  end

  test 'publish changes state to published' do
    admin = users(:admin)
    sign_in(admin)
    bulletin = bulletins(:under_moderation)
    assert bulletin.under_moderation?
    patch publish_admin_bulletin_url(bulletin)
    assert_response :redirect
    assert { Bulletin.where(id: bulletin.id).first.published? }
  end

  test 'reject changes state to rejected' do
    admin = users(:admin)
    sign_in(admin)
    bulletin = bulletins(:under_moderation)
    assert bulletin.under_moderation?
    patch reject_admin_bulletin_url(bulletin)
    assert_response :redirect
    assert { Bulletin.where(id: bulletin.id).first.rejected? }
  end

  test 'archive changes state to archived' do
    admin = users(:admin)
    sign_in(admin)
    bulletin = bulletins(:under_moderation)
    assert bulletin.under_moderation?
    patch archive_admin_bulletin_url(bulletin)
    assert_response :redirect
    assert { Bulletin.where(id: bulletin.id).first.archived? }
  end
end
