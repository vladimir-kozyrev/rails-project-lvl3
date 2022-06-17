# frozen_string_literal: true

require 'test_helper'

class Web::Admin::BulletinsControllerTest < ActionDispatch::IntegrationTest
  def setup
    admin = users(:admin)
    sign_in(admin)
  end

  test 'should get all bulletins' do
    get admin_bulletins_url
    assert_response :success
  end

  test 'publish changes state to published' do
    bulletin = bulletins(:under_moderation)
    patch publish_admin_bulletin_url(bulletin)
    assert_response :redirect
    assert { bulletin.reload.published? }
  end

  test 'reject changes state to rejected' do
    bulletin = bulletins(:under_moderation)
    patch reject_admin_bulletin_url(bulletin)
    assert_response :redirect
    assert { bulletin.reload.rejected? }
  end

  test 'archive changes state to archived' do
    bulletin = bulletins(:under_moderation)
    patch archive_admin_bulletin_url(bulletin)
    assert_response :redirect
    assert { bulletin.reload.archived? }
  end
end
