require 'test_helper'

class RestControllerTest < ActionController::TestCase
  test "should get api" do
    get :api
    assert_response :success
  end

end
