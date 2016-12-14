require 'selenium-webdriver'
require_relative "#{Dir.getwd}/context" if File.exist?("#{Dir.getwd}/context.rb")
require 'ostruct'
require 'openssl'
require 'net/http'
require 'RMagick'
include Magick

context = (defined?(Context) != nil) ? Context.instance : OpenStruct.new

is_import = context.driver != nil

module ChromeDriver
  def save_screenshot(path)
    scroll_point = 0
    screenshot_index = 0
    window_height = self.execute_script("return window.innerHeight")
    window_width = self.execute_script("return window.innerWidth")
    page_height = self.execute_script("return document.documentElement.scrollHeight")
    while page_height > scroll_point
      self.execute_script("scroll(0, #{scroll_point});")
      sleep 1
      super("#{path}.#{screenshot_index}.png")
      scroll_point += window_height
      screenshot_index += 1
    end
    base_image = Magick::Image.new(window_width, page_height)
    images = (0..screenshot_index-1).map {|index| "#{path}.#{index}.png" }
    scroll_point = 0
    images.each_with_index{|filename, index|
      scroll_point = page_height - window_height if (images.count == index + 1)
      img = Magick::Image.from_blob(File.read(filename)).shift
      base_image.composite!(img, 0, scroll_point, Magick::OverCompositeOp)
      scroll_point += window_height
      File.unlink filename
    }
    base_image.write(path)
    self.execute_script("scroll(0, 0);")
  end
end

if context.driver == nil || context.wait == nil
  download_directory = File.expand_path('__DOWNLOADDIR__')
  download_directory.gsub!("/", "\\") if  Selenium::WebDriver::Platform.windows?
  context.driver = Selenium::WebDriver.for :chrome, :prefs => {
    :download => {
      :prompt_for_download => false,
      :default_directory => download_directory
    }
  }
  context.driver.extend ChromeDriver
  context.wait = Selenium::WebDriver::Wait.new(:timeout => __WAITTIMEOUT__)
end

_driver = context.driver
_wait = context.wait

