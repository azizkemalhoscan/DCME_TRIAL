require 'test_helper'

class WelcomeMessagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get welcome_messages_index_url
    assert_response :success
  end

  test "should get show" do
    get welcome_messages_show_url
    assert_response :success
  end

  test "should get new" do
    get welcome_messages_new_url
    assert_response :success
  end

  test "should get create" do
    get welcome_messages_create_url
    assert_response :success
  end

  test "should get edit" do
    get welcome_messages_edit_url
    assert_response :success
  end

  test "should get update" do
    get welcome_messages_update_url
    assert_response :success
  end

  test "should get destroy" do
    get welcome_messages_destroy_url
    assert_response :success
  end

end
