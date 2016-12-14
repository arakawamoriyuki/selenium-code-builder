# coding:utf-8
import os as Os, sys as Sys, types as Types, re as Re, time as Time, json as Json
from datetime import datetime as Datetime
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
    profile = Webdriver.FirefoxProfile()
    download_directory = Os.getcwd()+'/__DOWNLOADDIR__'
    if Os.name == 'nt':
        download_directory = download_directory.replace('/', '\\')
    profile.set_preference('browser.download.dir', download_directory)
    profile.set_preference('browser.download.folderList', 2)
    profile.set_preference('browser.download.useDownloadDir', True)
    profile.set_preference('browser.helperApps.neverAsk.saveToDisk', 'text/plain;text/csv;image/gif;image/jpeg;image/png;image/vnd.microsoft.icon;application/zip;application/pdf;application/msword;application/msexcel;')
    context.driver = Webdriver.Firefox(profile)
    context.wait = WebDriverWait(context.driver, __WAITTIMEOUT__)

_driver = context.driver
_wait = context.wait

