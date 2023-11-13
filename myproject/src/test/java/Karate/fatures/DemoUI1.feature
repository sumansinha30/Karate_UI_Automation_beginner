Feature: Validating UI browser

  Background:
    * configure driver = { type: 'chrome', addOptions: ["--remote-allow-origins=*"], executable: 'C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe' }
    * configure afterScenario =
    """
    function(){
      karate.log('completed scenario:', karate.scenario.name);
      karate.log(karate.info)
      if(karate.info.errorMessage) {
        karate.log("ERROR ENCOUNTERED");
        karate.write(driver.screenshot(false), 'demo1.png')
        karate.call(DemoUI1.feature)
      }
    }
    """
    * configure afterFeature = function(){ karate.log('end of feature file'); }


  @Tag1
  Scenario: Open saucedemo.com in browser
#    * configure driver = {type: 'chromedriver', addOptions: ["--remote-allow-origins=*"], port: 2345 }
    Given driver "https://www.saucedemo.com/"
    Then delay(8000)
    Then input("#user-name", "standard_user")
    Then input("//input[@id='password']", "secret_sauce")
    And click("input[id=login-button]")
    Then delay(5000)


  @Tag2
  Scenario: Open bing.com in browser identify using linkText
    Given driver "https://www.saucedemo.com/"
    Then delay(8000)
    Then click("{a}Images")
#    Then click("{^a}Image")
#    Then click("^{a:3}Image")
    And click("input[id=login-button]")
    Then delay(5000)

  @Tag3
  Scenario: Open salesforce.com in browser identify using Friendly Locators
    Given driver "https://login.salesforce.com/"
    Then delay(8000)
    Then fullscreen()
    Then above("//label[@for='password']").find("input").input("surendra")
    Then below("//label[@for='password']").find("input").input("surendra")
    # By defaults these friendly locators search for input, so we can omit input
    Then leftOf("//label[@for='rememberUn']").click()
    Then rightOf("//p[@class='di mr16']").find("a").click()
    Then near("//div[@class='firstName textFieldInput section']").input("surendra")
    Then delay(17000)

  @Tag4
  Scenario: Open bing.com in browser to perform browser actions
    Given driver "https://www.bing.com/"
    Then delay(8000)
    Then maximize()
    Then minimize()
    Then fullscreen()
    Then delay(1000)
    Then refresh()
    Then delay(1000)
    Then reload()
    Then delay(1000)
    Then click("{a}Images")
    Then delay(3000)
    And back()
    Then delay(3000)
    And forward()
    And print driver.title
    And print driver.url
    Then match driver.url = "https://www.bing.com/images/feed?form=Z9LH"

  @Tag5
  Scenario: Open bing.com in browser to check browser dimensions and locator position
    Given driver "https://www.bing.com/"
    And delay(8000)
    And print driver.dimensions
    And driver.dimensions = { x: 20, y: 20, width: 300, height: 800 }
    And print driver.dimensions
    Then print position("#sb_form_q)

  @Tag6
  Scenario: Open bing.com in browser to capture screenshots
    Given driver "https://www.bing.com/"
    And delay(8000)
    And input("#sb_form_q", "pat cummins")
    Then screenshot()
    Then screenshot("#sb_form_q")

  @Tag7
  Scenario: Open salesforce.com in browser and handle keyboard, highlight, focus, submit, clear
    Given driver "https://login.salesforce.com/"
    Then delay(3000)
    Then maximize()
    And highlight("#username")
    Then input("#username", "surendra" + Key.TAB)
    Then delay(3000)
    And highlightAll('input')
    Then input("#password", "password" + Key.ENTER)
    Then delay(3000)
    And focus("#password")
    Then input("#password", "password")
    And clear("#password")
    Then delay(3000)
    And submit().click("#Login")

  @Tag8
  Scenario: Open bing.com in browser and handle dropdown
    Given driver "https://www.bing.com/account/general?ru="
    Then delay(7000)
    Then maximize()
    And highlightAll("select")
#    And select("#rpp", "1")
#    And select("#rpp", "15")
#    And select("#rpp", "{}30")
    And select("#rpp", "{^}Aut")
    Then delay(3000)

  @Tag9
  Scenario: Open the-internet.herokuapp.com in browser and handle alerts
    Given driver "https://the-internet.herokuapp.com/javascript_alerts"
    And delay(5000)
    Then maximize()
    And click("//button[@onclick='jsAlert()']")
    And match driver.dialog == "I am a JS Alert"
    Then dialog(true)
    Then delay(3000)
    And click("//button[@onclick='jsConfirm()']")
    Then dialog(false)
    Then delay(3000)
    And click("//button[@onclick='jsPrompt()']")
    Then dialog(true, 'some text')
    Then delay(3000)

  @Tag10
  Scenario: Open the-internet.herokuapp.com in browser and handle frames
    Given driver "https://the-internet.herokuapp.com/iframe"
    And delay(5000)
    Then maximize()
    And switchFrame("#mce_0_ifr")
    And input("#tinymce p", "So i am here")
    Then screenshot()
    And delay(5000)

  @Tag11
  Scenario: Open bing.com in browser and gettext, attribute and value
    Given driver "https://www.bing.com/"
    Then delay(7000)
    And maximize()
    And input("#sb_form_q", "surendra")
    And print(value("#sb_form_q"))
    And match attribute('#sb_form_q', 'placeholder') == 'Search the web'

  @Tag12
  Scenario: Open the-internet.herokuapp.com in browser and upload file
    Given driver "https://the-internet.herokuapp.com/upload"
    Then delay(7000)
    And maximize()
    * driver.inputFile('#file-upload', '/Users/Acer/Downloads/Bhai kya kar raha hai tu - Indian Meme Templates.jpg')
    * submit().click('#file-submit')
    * delay(5000)
    * waitForText('#uploaded-files', 'Bhai kya kar raha hai tu - Indian Meme Templates.jpg')

  @Tag13
  Scenario: Open hdfc.com in browser and multiple window handling
    Given driver "https://www.hdfc.com/"
    Then delay(7000)
    And maximize()
    And click("//li[@class='secondary-menu-item']/a[text()='Blogs']")
    Then delay(5000)
    And switchPage("HDFC Bank Ltd | Blog")
    Then delay(5000)
    And switchPage(0)
    And match driver.title == 'Home Loans | Housing Finance Company in India | HDFC Bank Ltd'
    And switchPage("hdfc.com/blog")
    Then delay(5000)

  @Tag13
  Scenario: Open hdfc.com in browser and scroll down to object
    Given driver "https://www.hdfc.com/"
    And maximize()
    Then delay(15000)
    Then scroll("//a[@title='Locate Us']").click()
    And delay(15000)