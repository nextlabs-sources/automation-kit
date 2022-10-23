# For Python 3

import subprocess
import urllib
import urllib.request
import os
import zipfile
from shutil import move

if not os.path.exists('download'):
    os.makedirs('download')

chrome_get_driver_version = "(Get-Item (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe').'(Default)').VersionInfo | % {('{0}' -f $_.ProductVersion)}"
chrome_driver_version = subprocess.run(["powershell", "-Command", chrome_get_driver_version], capture_output=True, shell=True).stdout.decode('utf-8').strip()
if chrome_driver_version=='':
    print('Chrome executable path not found in registry')
else:
    print ('Chrome driver version: '+chrome_driver_version)

    major_version = chrome_driver_version.split('.')[0]

    filedata = urllib.request.urlopen('https://chromedriver.storage.googleapis.com/LATEST_RELEASE_{0}'.format(major_version))
    latest_version_for_major_version = filedata.read().decode('utf-8')

    driver_url = 'https://chromedriver.storage.googleapis.com/{0}/chromedriver_win32.zip'.format(latest_version_for_major_version)
    print (driver_url)
    filedata = urllib.request.urlopen(driver_url)

    driver_zip = 'download/chromedriver_win32.zip'
    with open(driver_zip, 'wb') as f:
        f.write(filedata.read())

    with zipfile.ZipFile(driver_zip, 'r') as zip_ref:
        zip_ref.extractall('../pythonenv/Scripts')

edge_get_driver_version = "(Get-Item (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\msedge.exe').'(Default)').VersionInfo | % {('{0}' -f $_.ProductVersion)}"
edge_driver_version = subprocess.run(["powershell", "-Command", edge_get_driver_version], capture_output=True, shell=True).stdout.decode('utf-8').strip()
if edge_driver_version=='':
    print('Edge executable path not found in registry')
else:
    print ('Edge driver version: '+edge_driver_version)

    driver_url = 'https://msedgedriver.azureedge.net/{0}/edgedriver_win32.zip'.format(edge_driver_version.strip())
    print (driver_url)
    filedata = urllib.request.urlopen(driver_url)

    driver_zip = 'download/edgedriver_win32.zip'
    with open(driver_zip, 'wb') as f:
        f.write(filedata.read())

    with zipfile.ZipFile(driver_zip, 'r') as zip_ref:
        zip_ref.extract('msedgedriver.exe','../pythonenv/Scripts')

    #move('../pythonenv/Scripts/msedgedriver.exe','../pythonenv/Scripts/microsoftwebdriver.exe')

response = urllib.request.urlopen('https://github.com/mozilla/geckodriver/releases/latest')
ff_url = response.geturl()
ver = ff_url.rsplit('/',1)[1]
print ('latest version of geckodriver: {0}'.format(ver))

driver_url = 'https://github.com/mozilla/geckodriver/releases/download/{0}/geckodriver-{0}-win32.zip'.format(ver)
print (driver_url)
filedata = urllib.request.urlopen(driver_url)

driver_zip = 'download/geckodriver_win32.zip'
with open(driver_zip, 'wb') as f:
    f.write(filedata.read())

with zipfile.ZipFile(driver_zip, 'r') as zip_ref:
    zip_ref.extractall('../pythonenv/Scripts')
