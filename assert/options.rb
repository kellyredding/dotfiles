Assert::Test.options.capture_output  true
Assert::Test.options.halt_on_fail    false
Assert.options.view                  Assert::View::DefaultView.new($stdout)

# assert-view-testunit

#Assert::View.require_user_view 'assert-view-testunit'
#Assert.options.view                  Assert::View::TestUnitView.new($stdout)
#Assert.options.view                  Assert::View::RedgreenView.new($stdout)

# assert-view-leftright

#Assert::View.require_user_view 'assert-view-leftright'
#Assert.options.view                  Assert::View::LeftrightView.new($stdout)
#Assert.view.options.left_column_groupby   :file
#Assert.view.options.left_column_justify   :left
