Assert::Test.options.capture_output  true
Assert::Test.options.halt_on_fail false

# default view setting
Assert.options.view                  Assert::View::DefaultView.new($stdout)

# other views
# require 'assert/view/test_unit_view'
# Assert.options.view                  Assert::View::TestUnitView.new($stdout)

# require 'assert/view/redgreen_view'
# Assert.options.view                  Assert::View::RedgreenView.new($stdout)

# require 'assert/view/leftright_view'
# Assert.options.view                  Assert::View::LeftrightView.new($stdout)

Assert.view.options.styled                true
Assert.view.options.left_column_groupby   :file
Assert.view.options.left_column_justify   :left
Assert.view.options.right_column_width    115
