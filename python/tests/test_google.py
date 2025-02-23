import sys, os, pytest 
from utils.browser_setup import get_driver 
from pages.google_page import GooglePage 
 
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))) 
 
@pytest.fixture 
def driver(): 
    driver = get_driver() 
    yield driver 
    driver.quit() 
 
def test_google(driver): 
    google = GooglePage(driver) 
    google.open_google() 
    assert "Google" in driver.title