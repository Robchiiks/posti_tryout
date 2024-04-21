*** Settings ***
Documentation   This is a test scenario, where 2 stamps get added to cart, their data is validated and then additional tasks are done with the cart to further validate it is working correctly.
Library     SeleniumLibrary
Resource    ../Resources/variables.robot
Resource    ../Resources/keywords.robot
Suite Setup     Open Browser To Website

# This test case is quite flaky, for me 98% of the time works fine, but sometimes the comparison of lists fail.
*** Test Cases ***
Open site, proceed to Stamps page
    Go To ALL Stamps Page

Get Stamps, add too cart and validate shipping costs under 45Eur
    Select Stamps Get Their Data Go to Cart and Validate Cart     ${stamp_from_1}    ${stamp_to_2}

Go back to shopping page
    Go To Shopping Page

Add more stamps to cart and validate cart with no shipping costs over 45Eur
    Select Stamps Get Their Data Go to Cart and Validate Cart     ${stamp_from_2}    ${stamp_to_4}

Finnish postal code validation
     Go To Checkout
     Sleep  2s
     Enter Postal Code and Validate
     Sleep  1s

# I hate using Sleep in tests, but I could not get a good checkout validation scenario to validate Finnish postal code