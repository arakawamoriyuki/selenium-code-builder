require 'selenium-webdriver'
require_relative "#{Dir.getwd}/context" if File.exist?("#{Dir.getwd}/context.rb")
require 'ostruct'
require 'openssl'
require 'net/http'

context = (defined?(Context) != nil) ? Context.instance : OpenStruct.new

is_import = context.driver != nil

if context.driver == nil || context.wait == nil
  profile = Selenium::WebDriver::Firefox::Profile.new
  download_directory = File.expand_path('__DOWNLOADDIR__')
  download_directory.gsub!("/", "\\") if Selenium::WebDriver::Platform.windows?
  profile['browser.download.dir'] = download_directory
  profile['browser.download.folderList'] = 2
  profile['browser.download.useDownloadDir'] = true
  profile['browser.helperApps.neverAsk.saveToDisk'] = 'text/plain;text/csv;image/gif;image/jpeg;image/png;image/vnd.microsoft.icon;application/zip;application/pdf;application/msword;application/msexcel;'
  context.driver = Selenium::WebDriver.for :firefox,
    desired_capabilities: Selenium::WebDriver::Remote::Capabilities.firefox(),
    profile: profile
  context.wait = Selenium::WebDriver::Wait.new(:timeout => __WAITTIMEOUT__)
end

_driver = context.driver
_wait = context.wait

