# KDR: need to require in date explicitly b/c
# rubygems monkeypatches the Date class without
# actually requiring it in
require 'date'

require 'rubygems'

# print ActiveRecord SQL to STDOUT
if ENV.include?('RAILS_ENV') && !Object.const_defined?('RAILS_DEFAULT_LOGGER')
  # Rails 2
  require 'logger'
  RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)
elsif defined?(Rails)
  # Rails 3
  if Rails.logger
    Rails.logger = Logger.new(STDOUT)
    ActiveRecord::Base.logger = Rails.logger
  end
end

# Autocomplete
require 'irb/completion'

# History
unless IRB.conf[:HISTORY_FILE]
  require 'irb/ext/save-history'
  IRB.conf[:SAVE_HISTORY] = 100
  IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"
end

# Easily print methods local to an object's class
class Object
  def local_methods
    (methods - Object.instance_methods).sort
  end
end

