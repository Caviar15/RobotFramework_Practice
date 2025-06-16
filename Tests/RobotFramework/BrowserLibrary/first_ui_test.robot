*** Settings ***
Library    Browser

*** Variables ***
${URL}                  https://www.saucedemo.com/
${VALID_USERNAME}       standard_user
${VALID_PASSWORD}       secret_sauce
${LOCKED_OUT_USERNAME}  locked_out_user
${COMMON_PASSWORD}      secret_sauce
${LOCKED_OUT_ERROR_TEXT}    Epic sadface: Sorry, this user has been locked out.

${USERNAME_FIELD}       [data-test="username"]
${PASSWORD_FIELD}       [data-test="password"]
${LOGIN_BUTTON}         [data-test="login-button"]
${ERROR_MESSAGE_BOX}    .error-message-container.error


*** Test Cases ***
Successful Login Test
    Open Browser To Login Page
    Fill Text    ${USERNAME_FIELD}    ${VALID_USERNAME}
    Fill Text    ${PASSWORD_FIELD}    ${COMMON_PASSWORD}
    Click        ${LOGIN_BUTTON}
    Wait For Elements State    .title    visible    timeout=20s
    ${header}=    Get Text    .title
    Should Be Equal    ${header}    Products
    ${current_url}=    Get Url
    Should Contain     ${current_url}          inventory.html
    Close Browser

Failed Login With Locked Out User Test
    Open Browser To Login Page
    Fill Text    ${USERNAME_FIELD}    ${LOCKED_OUT_USERNAME}
    Fill Text    ${PASSWORD_FIELD}    ${COMMON_PASSWORD}
    Click        ${LOGIN_BUTTON}
    Wait For Elements State    ${ERROR_MESSAGE_BOX}    visible
    Get Text                   ${ERROR_MESSAGE_BOX}    ==    ${LOCKED_OUT_ERROR_TEXT}
    Close Browser

*** Keywords ***
Open Browser To Login Page
    New Browser    chromium    headless=false    args=["--disable-save-password-bubble"]
    New Context
    New Page       ${URL}
    Set Viewport Size    1280    800

Close Browser
    Browser.Close Browser