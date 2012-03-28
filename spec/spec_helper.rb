require 'bundler'
require File.join(File.dirname(File.expand_path(__FILE__)), '..', 'lib', 'lunker.rb')

Bundler.require

VCR.configure do |vcr|
  vcr.cassette_library_dir = File.join(File.dirname(File.expand_path(__FILE__)), '..', 'fixtures', 'vcr_cassettes')
  vcr.hook_into :webmock
end

RSpec.configure do |conf|
  conf.color_enabled = true
end
