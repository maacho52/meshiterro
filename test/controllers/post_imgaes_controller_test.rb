require "test_helper"

class PostImgaesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get post_imgaes_new_url
    assert_response :success
  end

  test "should get index" do
    get post_imgaes_index_url
    assert_response :success
  end

  test "should get show" do
    get post_imgaes_show_url
    assert_response :success
  end
end
