require 'test_helper'

class MicroCredentialsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @micro_credential = micro_credentials(:one)
  end

  test "should get index" do
    get micro_credentials_url
    assert_response :success
  end

  test "should get new" do
    get new_micro_credential_url
    assert_response :success
  end

  test "should create micro_credential" do
    assert_difference('MicroCredential.count') do
      post micro_credentials_url, params: { micro_credential: {  } }
    end

    assert_redirected_to micro_credential_url(MicroCredential.last)
  end

  test "should show micro_credential" do
    get micro_credential_url(@micro_credential)
    assert_response :success
  end

  test "should get edit" do
    get edit_micro_credential_url(@micro_credential)
    assert_response :success
  end

  test "should update micro_credential" do
    patch micro_credential_url(@micro_credential), params: { micro_credential: {  } }
    assert_redirected_to micro_credential_url(@micro_credential)
  end

  test "should destroy micro_credential" do
    assert_difference('MicroCredential.count', -1) do
      delete micro_credential_url(@micro_credential)
    end

    assert_redirected_to micro_credentials_url
  end
end
