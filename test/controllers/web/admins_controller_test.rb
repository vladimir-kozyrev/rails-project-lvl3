# frozen_string_literal: true

require 'test_helper'

class Web::AdminsControllerTest < ActionDispatch::IntegrationTest
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
