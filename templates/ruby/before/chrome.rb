require 'selenium-webdriver'
require_relative "#{Dir.getwd}/context" if File.exist?("#{Dir.getwd}/context.rb")
require 'ostruct'
require 'openssl'
require 'net/http'

context = (defined?(Context) != nil) ? Context.instance : OpenStruct.new

is_import = context.driver != nil

if context.driver == nil || context.wait == nil
  download_directory = File.expand_path('__DOWNLOADDIR__')
  download_directory.gsub!("/", "\\") if  Selenium::WebDriver::Platform.windows?
  context.driver = Selenium::WebDriver.for :chrome, :prefs => {
    :download => {
      :prompt_for_download => false,
      :default_directory => download_directory
    }
  }
  context.wait = Selenium::WebDriver::Wait.new(:timeout => __WAITTIMEOUT__)
end

_driver = context.driver
_wait = context.wait

