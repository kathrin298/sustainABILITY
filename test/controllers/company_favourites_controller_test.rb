require 'test_helper'

class CompanyFavouritesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get company_favourites_create_url
    assert_response :success
  end

end
