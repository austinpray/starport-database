require 'test_helper'

class SvgImagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @svg_image = svg_images(:one)
  end

  test "should get index" do
    get svg_images_url
    assert_response :success
  end

  test "should get new" do
    get new_svg_image_url
    assert_response :success
  end

  test "should create svg_image" do
    assert_difference('SvgImage.count') do
      post svg_images_url, params: { svg_image: { data: @svg_image.data, name: @svg_image.name, source: @svg_image.source } }
    end

    assert_redirected_to svg_image_url(SvgImage.last)
  end

  test "should show svg_image" do
    get svg_image_url(@svg_image)
    assert_response :success
  end

  test "should get edit" do
    get edit_svg_image_url(@svg_image)
    assert_response :success
  end

  test "should update svg_image" do
    patch svg_image_url(@svg_image), params: { svg_image: { data: @svg_image.data, name: @svg_image.name, source: @svg_image.source } }
    assert_redirected_to svg_image_url(@svg_image)
  end

  test "should destroy svg_image" do
    assert_difference('SvgImage.count', -1) do
      delete svg_image_url(@svg_image)
    end

    assert_redirected_to svg_images_url
  end
end
