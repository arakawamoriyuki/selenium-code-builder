require 'appium_lib'
require_relative "#{Dir.getwd}/context" if File.exist?("#{Dir.getwd}/context.rb")
require 'ostruct'
require 'openssl'
require 'net/http'

context = (defined?(Context) != nil) ? Context.instance : OpenStruct.new

is_import = context.driver != nil

if context.driver == nil || context.wait == nil
  context.driver = Appium::Driver.new({
    caps: {
      platformName:     '__PLATFORMNAME__',
      platformVersion:  '__PLATFORMVERSION__',
      deviceName:       'Android',
      automationName:   '__AUTOMATIONNAME__',
      browserName:      '__BROWSERNAME__',
      language:         '__LANGUAGE__',
      locale:           '__LOCALE__',
      unicodeKeyboard:  true,
    },
    appium_lib: {
      wait:             __WAITTIMEOUT__,
    },
  }).start_driver
  context.wait = Selenium::WebDriver::Wait.new(:timeout => __WAITTIMEOUT__)
end

_driver = context.driver
_wait = context.wait

