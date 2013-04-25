Assert.configure do |c|
  c.capture_output false
  c.halt_on_fail   false
  c.view           Assert::View::DefaultView.new($stdout)
end

# TODO: rework for new config/init pattern
# assert-view-testunit

#Assert::View.require_user_view 'assert-view-testunit'
#Assert.options.view                  Assert::View::TestUnitView.new($stdout)
#Assert.options.view                  Assert::View::RedgreenView.new($stdout)

# assert-view-leftright

#Assert::View.require_user_view 'assert-view-leftright'
#Assert.options.view                  Assert::View::LeftrightView.new($stdout)
#Assert.view.options.left_column_groupby   :file
#Assert.view.options.left_column_justify   :left
