from selenium.webdriver.common.by import By

class GooglePage:
    def __init__(self, driver):
        self.driver = driver 
        self.url = "https://www.google.com"
 
    def open_google(self):
        self.driver.get(self.url)