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

# Easily print methods local to an object's class
class Object
  def local_methods
    (methods - Object.instance_methods).sort
  end
end
