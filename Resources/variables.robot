*** Variables ***
#${BROWSER}    headlesschrome
${BROWSER}    chrome
#(maybe headless will run faster than UI one, but on my system both were the same. If there would be more tests/steps, the difference could be more apparent)
${URL}         https://www.posti.fi/en
${accept_policy_button_xpath}  //*[@id="onetrust-accept-btn-handler"]
${all_stamps_button_xpath}    //*[@id="send-letters-and-postcards-with-stamps"]/div[2]/div/div/a
${notification}     //*[@id="__next"]/div[2]/div/ul/li/div
${go_shopping_page_button}    //ul[@class="sc-hc1f10-11 sc-hc1f10-13 lianmh fjamPI"]/li[1]/a
${go_to_cart_button}         /html/body/div[1]/header/div/div/div[2]/ul/li[2]/span/li/a
${total_fee_in_cart}    //*[@id="cart-totals-subtotal-value"]
${delivery_fee}     //*[@id="cart-totals-tax-value"]
${checkout_button}      //*[@id="cart-totals-cta"]
${postal_code}      //*[@id="billing-postcode-field"]
${postal_error_code}        //*[@id="__next"]/div[2]/section[1]/div[2]/div/div/div[1]/ol/li[1]/form/div[7]/div[2]
${stamp_from_1}    1
${stamp_to_2}    2
${stamp_from_2}    2
${stamp_to_4}    4