require 'test_helper'

class ThankyouScreensControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get thankyou_screens_show_url
    assert_response :success
  end

  test "should get new" do
    get thankyou_screens_new_url
    assert_response :success
  end

  test "should get create" do
    get thankyou_screens_create_url
    assert_response :success
  end

  test "should get edit" do
    get thankyou_screens_edit_url
    assert_response :success
  end

  test "should get update" do
    get thankyou_screens_update_url
    assert_response :success
  end

  test "should get destroy" do
    get thankyou_screens_destroy_url
    assert_response :success
  end

end
