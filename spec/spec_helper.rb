require 'bundler'
require File.join(File.dirname(File.expand_path(__FILE__)), '..', 'lib', 'lunker.rb')

Bundler.require(:default)

RSpec.configure do |conf|
  conf.color_enabled = true
end
