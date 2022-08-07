require "test_helper"

class Api::Ver1::ItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_ver1_items_index_url
    assert_response :success
  end

  test "should get create" do
    get api_ver1_items_create_url
    assert_response :success
  end
end
