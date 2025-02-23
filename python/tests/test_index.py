import pytest 
from utils.browser_setup import get_driver 
from pages.index_page import IndexPage 
 
@pytest.fixture 
def driver(): 
    driver = get_driver() 
    yield driver 
    driver.quit() 
 
def test_form_submission(driver): 
    page = IndexPage(driver) 
    page.open() 
    page.fill_form("testuser", "password123", "test@example.com") 
    page.submit_form() 
 
def test_alert_button(driver): 
    page = IndexPage(driver) 
    page.open() 
    page.click_alert_button() 
    alert_text = page.get_alert_text() 
    assert alert_text == "This is a test alert!" 
 
def test_dynamic_text_change(driver): 
    page = IndexPage(driver) 
    page.open() 
    page.click_dynamic_button() 
    assert page.get_dynamic_text() == "Text Changed!"