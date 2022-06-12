# frozen_string_literal: true

require 'test_helper'

class Web::ProfilesControllerTest < ActionDispatch::IntegrationTest
  test 'should get profile' do
    user = users(:regular_user)
    sign_in(user)
    get profile_url
    assert_response :success
  end
end
