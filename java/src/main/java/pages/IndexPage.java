package pages;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;

public class IndexPage {
    private WebDriver driver;
 
    // Locators for the form, checkboxes, radio buttons, and other elements
    private By usernameInput = By.id("username");
    private By passwordInput = By.id("password");
    private By emailInput = By.id("email");
    private By submitButton = By.cssSelector("input[type='submit']");
    private By checkbox1 = By.id("checkbox1");
    private By checkbox2 = By.id("checkbox2");
    private By radio1 = By.id("radio1");
    private By radio2 = By.id("radio2");
    private By dropdown = By.id("dropdown");
    private By alertButton = By.id("alert-button");
    private By dynamicButton = By.id("dynamic-button");
    private By dynamicText = By.id("dynamic-text");

    public IndexPage(WebDriver driver) {
        this.driver = driver;
    }

    // Open the page
    public void openPage() {
        driver.get("http://127.0.0.1:5000/");  // Use the correct path to index.html
    }

    // Fill in the form fields
    public void fillForm(String username, String password, String email) {
        driver.findElement(usernameInput).sendKeys(username);
        driver.findElement(passwordInput).sendKeys(password);
        driver.findElement(emailInput).sendKeys(email);
    }

    // Submit the form
    public void submitForm() {
        driver.findElement(submitButton).click();
    }

    // Select checkboxes
    public void checkCheckboxes() {
        driver.findElement(checkbox1).click();
        driver.findElement(checkbox2).click();
    }

    // Select radio buttons
    public void selectRadioButton1() {
        driver.findElement(radio1).click();
    }

    public void selectRadioButton2() {
        driver.findElement(radio2).click();
    }

    // Interact with dropdown
    public void selectDropdownOption(String optionValue) {
        WebElement dropdownElement = driver.findElement(dropdown);
        dropdownElement.sendKeys(optionValue);  // Sending option text
    }

    // Click alert button
    public void clickAlertButton() {
        driver.findElement(alertButton).click();
    }

    // Click dynamic button to change text
    public void clickDynamicButton() {
        driver.findElement(dynamicButton).click();
    }

    // Get dynamic text
    public String getDynamicText() {
        return driver.findElement(dynamicText).getText();
    }

    // Check the table's first row content (Example)
    public String getTableFirstRow() {
        return driver.findElement(By.xpath("//table/tr[2]/td[2]")).getText();  // Get the name from the first row
    }
}