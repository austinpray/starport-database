require 'test_helper'

class CargoControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cargo = cargo(:one)
  end

  test "should get index" do
    get cargo_index_url
    assert_response :success
  end

  test "should get new" do
    get new_cargo_url
    assert_response :success
  end

  test "should create cargo" do
    assert_difference('Cargo.count') do
      post cargo_index_url, params: { cargo: { description: @cargo.description, person_id: @cargo.person_id, safefy_rating: @cargo.safefy_rating, weight: @cargo.weight } }
    end

    assert_redirected_to cargo_url(Cargo.last)
  end

  test "should show cargo" do
    get cargo_url(@cargo)
    assert_response :success
  end

  test "should get edit" do
    get edit_cargo_url(@cargo)
    assert_response :success
  end

  test "should update cargo" do
    patch cargo_url(@cargo), params: { cargo: { description: @cargo.description, person_id: @cargo.person_id, safefy_rating: @cargo.safefy_rating, weight: @cargo.weight } }
    assert_redirected_to cargo_url(@cargo)
  end

  test "should destroy cargo" do
    assert_difference('Cargo.count', -1) do
      delete cargo_url(@cargo)
    end

    assert_redirected_to cargo_index_url
  end
end
