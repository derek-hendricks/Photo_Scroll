require 'test_helper'

class MessagesHelperTest < ActionView::TestCase
	test "full title helper" do
    assert_equal full_title,         FILL_IN
    assert_equal full_title("Images"), FILL_IN
  end	
end





