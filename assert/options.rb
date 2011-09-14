Assert::Test.options.capture_output  true
Assert.options.view.options.styled   true

# default view setting
Assert.options.view                  Assert::View::DefaultView.new($stdout)
