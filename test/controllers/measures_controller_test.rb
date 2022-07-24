require "test_helper"

class MeasuresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @measure = measures(:one)
  end

  test "should get index" do
    get measures_url, as: :json
    assert_response :success
  end

  test "should create measure" do
    assert_difference("Measure.count") do
      post measures_url, params: { measure: { name: @measure.name } }, as: :json
    end

    assert_response :created
  end

  test "should show measure" do
    get measure_url(@measure), as: :json
    assert_response :success
  end

  test "should update measure" do
    patch measure_url(@measure), params: { measure: { name: @measure.name } }, as: :json
    assert_response :success
  end

  test "should destroy measure" do
    assert_difference("Measure.count", -1) do
      delete measure_url(@measure), as: :json
    end

    assert_response :no_content
  end
end
