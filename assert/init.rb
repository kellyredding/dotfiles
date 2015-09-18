Assert.configure do |c|
  c.capture_output false
  c.halt_on_fail   false
end

# TODO: rework for new config/init pattern
# assert-view-testunit

# Assert::View.require_user_view 'assert-view-testunit'
# Assert.config.view Assert::View::TestUnitView.new($stdout)
# Assert.config.view Assert::View::RedgreenView.new($stdout)

# assert-view-leftright

#Assert::View.require_user_view 'assert-view-leftright'
#Assert.config.view Assert::View::LeftrightView.new($stdout)
#Assert.view.options.left_column_groupby :file
#Assert.view.options.left_column_justify :left
