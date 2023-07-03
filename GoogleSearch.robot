*** Settings ***
Library             Selenium2Library

Suite Setup         Open Browser    ${URL}    ${BROWSER}
Suite Teardown      Close All Browsers


*** Variables ***
${URL}                      http://www.google.com
${BROWSER}                  Chrome
${search_input}             name=q
@{search_terms}             TestCrew    Robot Framework
${result_cards_class}       MjjYud


*** Test Cases ***
Google Search
    Maximize Browser Window
    FOR    ${search_term}    IN    @{search_terms}
        Wait Until Element Is Visible    ${search_input}    timeout=30
        Input Text    ${search_input}    ${search_term}
        Submit Form
        Wait Until Page Contains Element    ${result_cards_class}    timeout=10
        ${result_cards} =    Get WebElements    class:${result_cards_class}
        FOR    ${result_card}    IN    ${result_cards}
            Log    ${result_card.text}
            Element Should Contain    ${result_card}    ${search_term}
        END
    END
