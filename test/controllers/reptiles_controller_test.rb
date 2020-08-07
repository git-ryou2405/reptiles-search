require 'test_helper'

class ReptilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @reptile = reptiles(:one)
  end

  test "should get index" do
    get reptiles_url
    assert_response :success
  end

  test "should get new" do
    get new_reptile_url
    assert_response :success
  end

  test "should create reptile" do
    assert_difference('Reptile.count') do
      post reptiles_url, params: { reptile: { aname: @reptile.aname, area: @reptile.area, arrival_day: @reptile.arrival_day, description: @reptile.description, max: @reptile.max, price: @reptile.price, sales_status: @reptile.sales_status, sex: @reptile.sex, size: @reptile.size, tyep1: @reptile.tyep1, tyep2: @reptile.tyep2, user_id: @reptile.user_id } }
    end

    assert_redirected_to reptile_url(Reptile.last)
  end

  test "should show reptile" do
    get reptile_url(@reptile)
    assert_response :success
  end

  test "should get edit" do
    get edit_reptile_url(@reptile)
    assert_response :success
  end

  test "should update reptile" do
    patch reptile_url(@reptile), params: { reptile: { aname: @reptile.aname, area: @reptile.area, arrival_day: @reptile.arrival_day, description: @reptile.description, max: @reptile.max, price: @reptile.price, sales_status: @reptile.sales_status, sex: @reptile.sex, size: @reptile.size, tyep1: @reptile.tyep1, tyep2: @reptile.tyep2, user_id: @reptile.user_id } }
    assert_redirected_to reptile_url(@reptile)
  end

  test "should destroy reptile" do
    assert_difference('Reptile.count', -1) do
      delete reptile_url(@reptile)
    end

    assert_redirected_to reptiles_url
  end
end
