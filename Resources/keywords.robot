*** Settings ***
Library     ./utils.py
Library     Collections
Library     SeleniumLibrary
*** Keywords ***
Go To ALL Stamps Page
    Scroll Element Into View    xpath=${all_stamps_button_xpath}
    Click Application Element   xpath=${all_stamps_button_xpath}
    Switch Window   NEW

Open Browser To Website
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Click application element    xpath=${accept_policy_button_xpath}

Get Text If Visible
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}
    ${Text}    Get Text   ${locator}
    RETURN    ${Text}

Click Application Element
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}
    Wait Until Element Is Enabled    ${locator}
    Click Element    ${locator}

Get First Then Add N Stamps To Cart
    [Arguments]    ${start_number}     ${end_number}
    ${added_items}=    Create List
    FOR    ${index}    IN RANGE    ${start_number}     ${end_number}
        ${item_name}=    Get Text If Visible    xpath=/html/body/div[1]/div[2]/section[1]/div/div/div[2]/ul/li[${index}]/div/div[1]/div[2]/div
        Append To List    ${added_items}    ${item_name}

        ${item_price}=    Get Text If Visible    xpath=/html/body/div[1]/div[2]/section[1]/div/div/div[2]/ul/li[${index}]/div/div[2]/div
        ${r_item_price}=     Get Only Number    ${item_price}

        Append To List    ${added_items}    ${r_item_price}

        Click Application Element    xpath=/html/body/div[1]/div[2]/section[1]/div/div/div[2]/ul/li[${index}]/div/div[3]/div/button
        Wait Until Element Is Visible     ${notification}
    END
    RETURN    ${added_items}

Go To Cart
    Click Application Element    xpath=${go_to_cart_button}

Get All Items Data in Cart
    [Arguments]    ${start_number}     ${end_number}
    ${added_items}=    Create List
    FOR    ${index}    IN RANGE    ${start_number}     ${end_number}

        ${item_name}=    Get Text If Visible   xpath=//html/body/div[1]/div[3]/section[1]/div[2]/div/div[2]/ul/li[${index}]/div/div[2]/*[@id="cart-item-name"]
        Append To List    ${added_items}    ${item_name}
        ${item_price}=    Get Text If Visible    xpath=/html/body/div[1]/div[3]/section[1]/div[2]/div/div[2]/ul/li[${index}]/div/div[2]/div[2]
        ${r_item_price}=      Get Only Number   ${item_price}
        Append To List    ${added_items}    ${r_item_price}
    END
    RETURN    ${added_items}

Go To Shopping Page
    Click Application Element    xpath=${go_shopping_page_button}

Check Total and Delivery Fee
    ${total_price}=    Get Text    xpath=${total_fee_in_cart}
    ${r_total_price}=      Get Only Number   ${total_price}
    ${delivery_fee}=    Get Text    xpath=${delivery_fee}
    ${r_delivery_fee}=      Get Only Number   ${delivery_fee}
    IF      ${r_total_price} < 45
            Should Not Be Equal   ${r_delivery_fee}   0.0
    END
    IF      ${r_total_price} >= 45
            Should Be Equal As Numbers   ${r_delivery_fee}   0.0
    END

Add N Stamps To Cart
    [Arguments]    ${start_number}     ${end_number}
    ${added_items}      Get First Then Add N Stamps To Cart    ${start_number}     ${end_number}
    RETURN    ${added_items}

Get All Items From Cart
    [Arguments]    ${start_number}     ${end_number}
    ${items_in_cart}    Get All Items Data in Cart      ${start_number}     ${end_number}
    RETURN    ${items_in_cart}

Check Total and Delivery Fee in Cart Page
    Go To Cart
    Check Total and Delivery Fee

Go To Checkout
    Click Application Element     xpath=${checkout_button}

Select Stamps Get Their Data Go to Cart and Validate Cart
    [Arguments]    ${start_number}     ${end_number}
    ${added_items}     Add N Stamps To Cart    ${start_number}     ${end_number}
    Go To Cart
    ${items_in_cart}    Get All Items From Cart    ${start_number}     ${end_number}
    Check Whether Items Correctly Added    ${items_in_cart}     ${added_items}
    Check Total and Delivery Fee in Cart Page

Check Whether Items Correctly Added
    [Arguments]    ${items_in_cart}     ${added_items}
    Lists Should Be Equal    ${added_items}    ${items_in_cart}

Enter Postal Code and Validate
   click element    ${postal_code}
   input text   ${postal_code}  12345
   element should not be visible    ${postal_error_code}