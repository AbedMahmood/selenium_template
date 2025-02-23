import sys, os 
from pages.google_page import GooglePage

sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

def test_google(driver):
    google = GooglePage(driver)
    google.open_google()
    assert "Google" in driver.title