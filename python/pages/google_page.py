from selenium.webdriver.common.by import By 
 
class GooglePage: 
    def __init__(self, driver): 
        self.driver = driver 
        self.search_box = (By.NAME, "q") 

    def open_google(self): 
        self.driver.get("https://www.google.com") 

    def search(self, query): 
        self.driver.find_element(*self.search_box).send_keys(query) 
        self.driver.find_element(*self.search_box).submit() 
 
    def get_results(self): 
        return self.driver.find_element(By.ID, "search").text  # Just a placeholder for search result