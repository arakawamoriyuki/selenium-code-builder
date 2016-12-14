# coding:utf-8
import os as Os, sys as Sys, types as Types, re as Re, time as Time, json as Json
from datetime import datetime as Datetime
from appium import webdriver as Webdriver
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
    context.driver = Webdriver.Remote('http://localhost:4723/wd/hub', {
        'platformName':     '__PLATFORMNAME__',
        'platformVersion':  '__PLATFORMVERSION__',
        'deviceName':       'Android',
        'automationName':   '__AUTOMATIONNAME__',
        'browserName':      '__BROWSERNAME__',
        'language':         '__LANGUAGE__',
        'locale':           '__LOCALE__',
        'unicodeKeyboard':  True,
    })
    context.wait = WebDriverWait(context.driver, __WAITTIMEOUT__)

_driver = context.driver
_wait = context.wait

