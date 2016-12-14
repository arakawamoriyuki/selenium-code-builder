# coding:utf-8
import os as Os, sys as Sys, types as Types, re as Re, time as Time, json as Json
from datetime import datetime as Datetime
from PIL import Image
from selenium import webdriver as Webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.ui import WebDriverWait, Select

if Os.path.exists('context.py'):
    from context import Context
    context = Context()
else:
    context = type('lamdbaobject', (object,), {})()

is_import = hasattr(context, 'driver')

if not hasattr(context, 'driver') or not hasattr(context, 'wait'):
    chromeOptions = Webdriver.ChromeOptions()
    download_directory = Os.getcwd()+'/__DOWNLOADDIR__'
    if Os.name == 'nt':
        download_directory = download_directory.replace('/', '\\')
    chromeOptions.add_experimental_option("prefs", {"download.default_directory" : download_directory})
    context.driver = Webdriver.Chrome(chrome_options=chromeOptions)
    context.wait = WebDriverWait(context.driver, __WAITTIMEOUT__)

def save_screenshot(context, path):
    scroll_point = 0
    screenshot_index = 0
    window_height = context.execute_script("return window.innerHeight")
    window_width = context.execute_script("return window.innerWidth")
    page_height = context.execute_script("return document.documentElement.scrollHeight")
    while page_height > scroll_point:
        context.execute_script("scroll(0, {0});".format(scroll_point))
        Time.sleep(1)
        context.save_screenshot_old(u"{0}.{1}.png".format(path, screenshot_index))
        scroll_point += window_height
        screenshot_index += 1
    base_image = Image.new('RGB', (window_width, page_height), (255, 255, 255))
    images = map(lambda index: u"{0}.{1}.png".format(path, index), xrange(0, screenshot_index))
    scroll_point = 0
    for index, filename in enumerate(images):
        if (len(images) == index + 1): scroll_point = page_height - window_height
        pasteImage = Image.open(filename, 'r')
        base_image.paste(pasteImage, (0, scroll_point))
        scroll_point += window_height
        Os.remove(filename)
    base_image.save(path, 'PNG', quality=100, optimize=True)
    context.execute_script("scroll(0, 0);")
context.driver.save_screenshot_old = context.driver.save_screenshot
context.driver.save_screenshot = Types.MethodType(save_screenshot, context.driver)

_driver = context.driver
_wait = context.wait

