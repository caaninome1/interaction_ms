require "test_helper"

class UsersMatchesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @users_match = users_matches(:one)
  end

  test "should get index" do
    get users_matches_url, as: :json
    assert_response :success
  end

  test "should create users_match" do
    assert_difference("UsersMatch.count") do
      post users_matches_url, params: { users_match: { date: @users_match.date, match_id: @users_match.match_id } }, as: :json
    end

    assert_response :created
  end

  test "should show users_match" do
    get users_match_url(@users_match), as: :json
    assert_response :success
  end

  test "should update users_match" do
    patch users_match_url(@users_match), params: { users_match: { date: @users_match.date, match_id: @users_match.match_id } }, as: :json
    assert_response :success
  end

  test "should destroy users_match" do
    assert_difference("UsersMatch.count", -1) do
      delete users_match_url(@users_match), as: :json
    end

    assert_response :no_content
  end
end
