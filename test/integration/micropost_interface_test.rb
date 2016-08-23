require 'test_helper'

class MicropostInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:fred)
    @one = users(:one)
  end

  test "micropost interface" do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'
    assert_select 'input[type=file]'

    assert_no_difference 'Micropost.count' do
      post microposts_path, params: {micropost: {content: ""}}
    end
    assert_select 'div#error_explanation'
    content = "This content really ties the room together"
    picture = fixture_file_upload('test/fixtures/images/image1.jpeg', 'image/jpg')
    assert_difference 'Micropost.count',1 do
      post microposts_path, params: {micropost:{content: content, picture: picture}}
    end
    assert assigns(:micropost).picture?
    assert_redirected_to root_url
    follow_redirect!
    assert_match content, response.body
    assert_select 'a', 'delete'
    first_micropost = @user.microposts.paginate(page: 1).first
    assert_difference 'Micropost.count', -1 do
      delete micropost_path(first_micropost)
    end
    assert !flash.empty?
    get user_path(@one)
    assert_select 'a', text: 'delete', count: 0
  end
  test "micropost sidebar count" do
    log_in_as(@user)
    get root_path
    assert_match "#{@user.microposts.count}", response.body
    log_in_as(@one)
    get root_path
    assert_match "0 microposts", response.body
    @one.microposts.create!(content: "ipsum ipsum lorca")
    get root_path
    assert_match "#{@one.microposts.count}", response.body
    assert_equal 1, @one.microposts.count

  end
  # test "the truth" do
  #   assert true
  # end
end
