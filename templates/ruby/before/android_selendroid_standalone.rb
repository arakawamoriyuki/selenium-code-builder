require 'selenium-webdriver'
require_relative "#{Dir.getwd}/context" if File.exist?("#{Dir.getwd}/context.rb")
require 'ostruct'
require 'openssl'
require 'net/http'

context = (defined?(Context) != nil) ? Context.instance : OpenStruct.new

is_import = context.driver != nil

if context.driver == nil || context.wait == nil
  context.driver = Selenium::WebDriver.for :remote, :desired_capabilities => :android
  context.wait = Selenium::WebDriver::Wait.new(:timeout => __WAITTIMEOUT__)
end

_driver = context.driver
_wait = context.wait

