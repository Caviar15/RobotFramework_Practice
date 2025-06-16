***Settings***
Library           SeleniumLibrary

***Variables***
${BROWSER}                      chrome
${URL}                          https://www.saucedemo.com/
${VALID_USERNAME}               standard_user
${VALID_PASSWORD}               secret_sauce
${LOCKED_OUT_USERNAME}          locked_out_user
${COMMON_PASSWORD}              secret_sauce
${ERROR_MESSAGE_TEXT}           Epic sadface: Sorry, this user has been locked out.

${USERNAME_FIELD}               id=user-name
${PASSWORD_FIELD}               id=password
${LOGIN_BUTTON}                 id=login-button
${ERROR_MESSAGE}                css=.error-message-container.error

${ADD_TO_CART_SAUCE_LABS_BACKPACK}    id=add-to-cart-sauce-labs-backpack
${SHOPPING_CART_ICON}           css=.shopping_cart_link
${CHECKOUT_BUTTON}              id=checkout
${FIRST_NAME_FIELD}             id=first-name
${LAST_NAME_FIELD}              id=last-name
${POSTAL_CODE_FIELD}            id=postal-code
${CONTINUE_BUTTON}              id=continue
${FINISH_BUTTON}                id=finish
${ORDER_CONFIRMATION_HEADER}    css=.complete-header
${BURGER_MENU_BUTTON}           id=react-burger-menu-btn
${LOGOUT_LINK}                  id=logout_sidebar_link

# New Variables for Remove Item Test Case
${REMOVE_BACKPACK_BUTTON}       id=remove-sauce-labs-backpack
${CART_ITEM}                    css=.cart_item
${SHOPPING_CART_BADGE}          css=.shopping_cart_badge


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

Successful Purchase Workflow
    Open Browser To Login Page
    Enter Valid Credentials
    Click Login Button
    Verify Successful Login
    Add Backpack To Cart
    Navigate To Cart
    Proceed To Checkout
    Fill And Submit Checkout Information
    Finish Order
    Verify Order Confirmation
    Logout From Application
    Close Browser

Remove Item From Cart Test
    Open Browser To Login Page
    Enter Valid Credentials
    Click Login Button
    Verify Successful Login
    Add Backpack To Cart
    Navigate To Cart
    Remove Backpack From Cart
    Verify Cart Is Empty
    Close Browser

***Keywords***
Open Browser To Login Page
    ${options}=     Evaluate        sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method     ${options}      add_argument    --incognito
    Call Method     ${options}      add_argument    --disable-save-password-bubble
    Open Browser    ${URL}          ${BROWSER}      options=${options}
    Maximize Browser Window
    Delete All Cookies
    Set Selenium Speed      0.5s
    Set Selenium Implicit Wait      5s

Enter Valid Credentials
    Input Text      ${USERNAME_FIELD}       ${VALID_USERNAME}
    Input Text      ${PASSWORD_FIELD}       ${COMMON_PASSWORD}

Enter Invalid Credentials (Locked Out)
    Input Text      ${USERNAME_FIELD}       ${LOCKED_OUT_USERNAME}
    Input Text      ${PASSWORD_FIELD}       ${COMMON_PASSWORD}

Click Login Button
    Click Element   ${LOGIN_BUTTON}

Verify Successful Login
    Location Should Contain     /inventory.html
    Wait Until Element Is Visible       css=.header_secondary_container .title      timeout=20s
    Page Should Contain Element         css=.header_secondary_container .title

Verify Error Message Displayed For Locked Out User
    Wait Until Element Is Visible       ${ERROR_MESSAGE}        timeout=20s
    Element Text Should Be      ${ERROR_MESSAGE}        ${ERROR_MESSAGE_TEXT}

Add Backpack To Cart
    Click Element   ${ADD_TO_CART_SAUCE_LABS_BACKPACK}
    Wait Until Element Is Visible   ${SHOPPING_CART_BADGE}

Navigate To Cart
    Click Element   ${SHOPPING_CART_ICON}
    Wait Until Location Is        ${URL}cart.html

Proceed To Checkout
    Wait Until Element Is Visible   ${CHECKOUT_BUTTON}
    Click Element   ${CHECKOUT_BUTTON}
    Wait Until Location Is        ${URL}checkout-step-one.html

Fill And Submit Checkout Information
    Input Text      ${FIRST_NAME_FIELD}     John
    Input Text      ${LAST_NAME_FIELD}      Doe
    Input Text      ${POSTAL_CODE_FIELD}    90210
    Click Element   ${CONTINUE_BUTTON}
    Wait Until Location Is        ${URL}checkout-step-two.html

Finish Order
    Click Element   ${FINISH_BUTTON}
    Wait Until Location Is        ${URL}checkout-complete.html

Verify Order Confirmation
    Wait Until Element Is Visible       ${ORDER_CONFIRMATION_HEADER}        timeout=20s
    Element Text Should Be      ${ORDER_CONFIRMATION_HEADER}        Thank you for your order!

Logout From Application
    Click Element   ${BURGER_MENU_BUTTON}
    Wait Until Element Is Visible   ${LOGOUT_LINK}
    Click Element   ${LOGOUT_LINK}
    Wait Until Location Is          ${URL}

# New Keywords for Remove Item Test Case
Remove Backpack From Cart
    Wait Until Element Is Visible   ${REMOVE_BACKPACK_BUTTON}
    Click Element   ${REMOVE_BACKPACK_BUTTON}

Verify Cart Is Empty
    Element Should Not Be Visible   ${CART_ITEM}
    Element Should Not Be Visible   ${SHOPPING_CART_BADGE}
