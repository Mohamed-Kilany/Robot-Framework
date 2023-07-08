*** Settings ***
Library     RequestsLibrary
Library     JSONLibrary

*** Variables ***
${Base_URL}     https://reqres.in/api/users
${User_ID}      1
${Status_OK}    200

*** Test Cases ***
Create User
    ${requestBody} =    Create Dictionary    name=SomeOne   job=AutomationDeveloper
    ${response} =  POST     ${Base_URL}     ${requestBody}
    ${id_path} =  Get Value From Json  ${response.json()}     id
    ${id} =     Convert To String	    ${id_path}[0]
    Should Not Be Empty    ${id}

Get User
    ${response} =  GET  ${Base_URL}/${User_ID}
    ${id_path} =  Get Value From Json  ${response.json()}     data.id
    ${id} =     Convert To String	    ${id_path}[0]
    ${status_code} =   Convert To String  ${response.status_code}
    Should Be Equal       ${id}     ${User_ID}
    Should Be Equal        ${status_code}   ${Status_OK}

