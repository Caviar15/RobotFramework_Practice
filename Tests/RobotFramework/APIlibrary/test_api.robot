*** Settings ***
Library           RequestsLibrary
Library           Collections

*** Variables ***
${BASE_URL}        https://reqres.in/api
${LOGIN_ENDPOINT}  /login
${VALID_EMAIL}     eve.holt@reqres.in
${VALID_PASSWORD}  cityslicka

*** Test Cases ***
API Login Test - Successful
    Create Session    my_session    ${BASE_URL}
    ${headers}=       Create Dictionary    Content-Type=application/json    x-api-key=reqres-free-v1
    ${body}=          Create Dictionary    email=${VALID_EMAIL}    password=${VALID_PASSWORD}
    ${resp}=          POST On Session    my_session    ${LOGIN_ENDPOINT}    json=${body}    headers=${headers}    verify=${FALSE}
    Log               Status Code: ${resp.status_code}
    Log               Body: ${resp.text}
    Status Should Be  200    ${resp}
    Dictionary Should Contain Key    ${resp.json()}    token