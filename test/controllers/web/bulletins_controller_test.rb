# frozen_string_literal: true

require 'test_helper'

class Web::BulletinsControllerTest < ActionDispatch::IntegrationTest
  def setup
    auth_hash = {
      provider: 'github',
      uid: '12345',
      info: {
        email: Faker::Internet.email,
        name: Faker::Name.first_name
      }
    }
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash::InfoHash.new(auth_hash)
    get callback_auth_url('github')
  end

  test 'should get index' do
    get bulletins_url
    assert_response :success
  end

  test 'should get new' do
    get new_bulletin_url
    assert_response :success
  end

  test 'should create bulletin' do
    user = users(:regular_user)
    category = categories(:one)
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
end
