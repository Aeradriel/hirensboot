require 'test_helper'

class WindowsImagesControllerTest < ActionController::TestCase
  setup do
    @windows_image = windows_images(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:windows_images)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create windows_image" do
    assert_difference('WindowsImage.count') do
      post :create, windows_image: {  }
    end

    assert_redirected_to windows_image_path(assigns(:windows_image))
  end

  test "should show windows_image" do
    get :show, id: @windows_image
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @windows_image
    assert_response :success
  end

  test "should update windows_image" do
    patch :update, id: @windows_image, windows_image: {  }
    assert_redirected_to windows_image_path(assigns(:windows_image))
  end

  test "should destroy windows_image" do
    assert_difference('WindowsImage.count', -1) do
      delete :destroy, id: @windows_image
    end

    assert_redirected_to windows_images_path
  end
end
