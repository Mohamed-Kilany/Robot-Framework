*** Settings ***
Library     Selenium2Library
Library     String


*** Variables ***
@{search_engines}       https://www.google.com    https://www.bing.com
${google}               https://www.google.com
${bing}                 https://www.bing.com
${results_google}       MjjYud
${results_bing}         b_algo
${BROWSER}              Chrome
${search_input}         name=q
@{search_terms}         TestCrew    Robot Framework


*** Test Cases ***
Test for Search
    [Tags]    [search]
    FOR    ${search_engine}    IN    @{search_engines}
        Open Browser    ${search_engine}    ${BROWSER}
        Maximize Browser Window
        FOR    ${search_term}    IN    @{search_terms}
            Wait Until Element Is Visible    ${search_input}    timeout=10
            Input Text    ${search_input}    ${search_term}
            Submit Form
            ${URL} =    Get Location
            IF    '${google}' in '${URL}'
                ${result_cards} =    Get WebElements    class:${results_google}
                Wait Until Page Contains Element    class:${results_google}    timeout=10
                FOR    ${result_card}    IN    ${result_cards}
                Element Should Contain    class:${results_google}    ${search_term}
                END
            ELSE IF    '${bing}' in '${URL}'
                ${result_cards} =    Get WebElements    class:${results_bing}
                Wait Until Page Contains Element    class:${results_bing}    timeout=10
                FOR    ${result_card}    IN    ${result_cards}
                Element Should Contain    class:${results_bing}    ${search_term}
                END
            END
        END
    END
