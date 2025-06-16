***Settings***
Library    SeleniumLibrary

***Variables***
${BROWSER}              chrome
${URL}                  https://www.saucedemo.com/
${VALID_USERNAME}       standard_user
${VALID_PASSWORD}       secret_sauce
${LOCKED_OUT_USERNAME}  locked_out_user
${COMMON_PASSWORD}      secret_sauce
${ERROR_MESSAGE_TEXT}   Epic sadface: Sorry, this user has been locked out.

${USERNAME_FIELD}       id=user-name
${PASSWORD_FIELD}       id=password
${LOGIN_BUTTON}         id=login-button
${ERROR_MESSAGE}        css=.error-message-container.error

***Test Cases***
Valid Login Test
    Open Browser To Login Page
    Enter Valid Credentials
    Click Login Button
    Verify Successful Login
    Close Browser

Invalid Login Test - Locked Out User
    Open Browser To Login Page
    Enter Invalid Credentials (Locked Out)
    Click Login Button
    Verify Error Message Displayed For Locked Out User
    Close Browser

***Keywords***
Open Browser To Login Page
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${options}    add_argument    --incognito
    Call Method    ${options}    add_argument    --disable-save-password-bubble
    Open Browser    ${URL}    ${BROWSER}    options=${options}
    Maximize Browser Window
    Delete All Cookies
    Set Selenium Speed      0.5s
    Set Selenium Implicit Wait    5s

Enter Valid Credentials
    Input Text    ${USERNAME_FIELD}    ${VALID_USERNAME}
    Input Text    ${PASSWORD_FIELD}    ${COMMON_PASSWORD}

Enter Invalid Credentials (Locked Out)
    Input Text    ${USERNAME_FIELD}    ${LOCKED_OUT_USERNAME}
    Input Text    ${PASSWORD_FIELD}    ${COMMON_PASSWORD}

Click Login Button
    Click Element    ${LOGIN_BUTTON}

Verify Successful Login
    Location Should Contain    /inventory.html
    Wait Until Element Is Visible    css=.header_secondary_container .title    timeout=20s
    Page Should Contain Element      css=.header_secondary_container .title

Verify Error Message Displayed For Locked Out User
    Wait Until Element Is Visible    ${ERROR_MESSAGE}    timeout=20s
    Element Text Should Be    ${ERROR_MESSAGE}    ${ERROR_MESSAGE_TEXT}