from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

class IndexPage:
    def __init__(self, driver):
        self.driver = driver
        self.url = "http://127.0.0.1:5000/"

    def open(self):
        self.driver.get(self.url)
 
    def fill_form(self, username, password, email):
        self.driver.find_element(By.ID, "username").send_keys(username)
        self.driver.find_element(By.ID, "password").send_keys(password)
        self.driver.find_element(By.ID, "email").send_keys(email)
 
    def submit_form(self):
        self.driver.find_element(By.CSS_SELECTOR, "input[type='submit']").click()
 
    def get_alert_text(self):
        alert = WebDriverWait(self.driver, 5).until(EC.alert_is_present())
        return alert.text
 
    def click_alert_button(self):
        self.driver.find_element(By.ID, "alert-button").click()
 
    def click_dynamic_button(self):
        self.driver.find_element(By.ID, "dynamic-button").click()
 
    def get_dynamic_text(self):
        return self.driver.find_element(By.ID, "dynamic-text").text