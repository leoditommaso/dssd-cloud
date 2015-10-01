require 'test_helper'

class ViewFilesControllerTest < ActionController::TestCase
  setup do
    @view_file = view_files(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:view_files)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create view_file" do
    assert_difference('ViewFile.count') do
      post :create, view_file: {  }
    end

    assert_redirected_to view_file_path(assigns(:view_file))
  end

  test "should show view_file" do
    get :show, id: @view_file
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @view_file
    assert_response :success
  end

  test "should update view_file" do
    patch :update, id: @view_file, view_file: {  }
    assert_redirected_to view_file_path(assigns(:view_file))
  end

  test "should destroy view_file" do
    assert_difference('ViewFile.count', -1) do
      delete :destroy, id: @view_file
    end

    assert_redirected_to view_files_path
  end
end
