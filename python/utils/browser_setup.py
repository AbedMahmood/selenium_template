from selenium import webdriver 
from selenium.webdriver.edge.service import Service 
from webdriver_manager.microsoft import EdgeChromiumDriverManager 
 
def get_driver(): 
    service = Service(EdgeChromiumDriverManager().install())  # Correct way to set up the service 
    driver = webdriver.Edge(service=service)  # Pass service to WebDriver 
    driver.maximize_window() 
    return driver