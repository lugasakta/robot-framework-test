*** Settings ***
Documentation  Simple example using AppiumLibrary
Library  AppiumLibrary
Test Tags  webdriver
Suite Setup  Open Test Application

*** Variables ***
${ANDROID_AUTOMATION_NAME}    UIAutomator2
${ANDROID_APP}                ${CURDIR}/mda-2.2.0-25.apk
${ANDROID_PLATFORM_NAME}      Android
${ANDROID_PLATFORM_VERSION}   %{ANDROID_PLATFORM_VERSION=13}
${APPIUM SERVER URL}  http://127.0.0.1:4723 
${WAIT_TIME_OUT}  20

*** Test Cases ***
User should be success login when login using valid data
  User should be on homepage
  User go to login page
  User should be on login page
  User login using valid data
  User validate Log Out text appears on sidebar menu

User should be success to logout from sidebar menu
  User should be on sidebar menu
  User click logout on sidebar menu
  User choose to logout
  User will be redirect to login page

User can not login using locked out account
  User login using locked out account
  User should see error message on login page

*** Keywords ***
Open Test Application
  Open Application  ${APPIUM SERVER URL}  automationName=${ANDROID_AUTOMATION_NAME}
  ...  platformName=${ANDROID_PLATFORM_NAME}  platformVersion=${ANDROID_PLATFORM_VERSION}
  ...  app=${ANDROID_APP}  appWaitActivity=*

User should be on home page
  Wait Until Page Contains Element  id=com.saucelabs.mydemoapp.android:id/mTvTitle  timeout=${WAIT_TIME_OUT}

User go to login page
  click element  id=com.saucelabs.mydemoapp.android:id/menuIV
  Wait Until Page Contains Element  xpath=//android.widget.TextView[@content-desc="Login Menu Item"]
  click element  xpath=//android.widget.TextView[@content-desc="Login Menu Item"]

User should be on login page
  wait until page contains element  id=com.saucelabs.mydemoapp.android:id/loginTV

User login using valid data
  input text  id=com.saucelabs.mydemoapp.android:id/nameET  bod@example.com
  input text  id=com.saucelabs.mydemoapp.android:id/passwordET  10203040
  click element  id=com.saucelabs.mydemoapp.android:id/loginBtn

User validate Log Out text appears on sidebar menu
  wait until page contains element  id=com.saucelabs.mydemoapp.android:id/menuIV  timeout=${WAIT_TIME_OUT}
  click element  id=com.saucelabs.mydemoapp.android:id/menuIV
  Page Should Contain Element  xpath=//android.widget.TextView[@content-desc="Logout Menu Item"]

User should be on sidebar menu
  page should contain element  id=com.saucelabs.mydemoapp.android:id/menuRV

User click logout on sidebar menu
  Page Should Contain Element  xpath=//android.widget.TextView[@content-desc="Logout Menu Item"]
  click element  xpath=//android.widget.TextView[@content-desc="Logout Menu Item"]

User choose to logout
  page should contain element  id=com.saucelabs.mydemoapp.android:id/parentPanel
  click element  id=android:id/button1

User will be redirect to login page
  wait until page contains element  id=com.saucelabs.mydemoapp.android:id/loginTV

User login using locked out account
  input text  id=com.saucelabs.mydemoapp.android:id/nameET  alice@example.com (locked out)
  input text  id=com.saucelabs.mydemoapp.android:id/passwordET  10203040
  click element  id=com.saucelabs.mydemoapp.android:id/loginBtn

User should see error message on login page
  page should contain element  id=com.saucelabs.mydemoapp.android:id/passwordErrorTV
