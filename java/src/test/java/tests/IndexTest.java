package tests; 
 
import com.aventstack.extentreports.ExtentReports; 
import com.aventstack.extentreports.ExtentTest; 
import com.aventstack.extentreports.reporter.ExtentSparkReporter; 
import org.openqa.selenium.Alert; 
import org.openqa.selenium.WebDriver; 
import org.testng.Assert; 
import org.testng.annotations.AfterClass; 
import org.testng.annotations.BeforeClass; 
import org.testng.annotations.Test; 
import pages.IndexPage; 
import utils.BrowserSetup; 
 
public class IndexTest { 
    WebDriver driver; 
    IndexPage indexPage; 
    ExtentReports extent; 
    ExtentTest test; 
 
    @BeforeClass 
    public void setup() { 
        driver = BrowserSetup.getDriver(); 
        indexPage = new IndexPage(driver); 
 
        // Initialize Extent Report for HTML output 
        ExtentSparkReporter sparkReporter = new ExtentSparkReporter("reports/IndexReport.html"); 
        extent = new ExtentReports(); 
        extent.attachReporter(sparkReporter); 
    } 
 
    @Test 
    public void testFormSubmission() { 
        test = extent.createTest("Form Submission Test"); 
        indexPage.openPage(); 
        indexPage.fillForm("uertest", "password123", "test@example.com"); 
        indexPage.submitForm(); 
        test.pass("Form submitted successfully"); 
    } 
 
    @Test 
    public void testAlertButton() { 
        test = extent.createTest("Alert Button Test"); 
        indexPage.openPage(); 
        indexPage.clickAlertButton(); 
        Alert alert = driver.switchTo().alert(); 
        String alertText = alert.getText(); 
        alert.accept(); 
        Assert.assertEquals(alertText, "This is a test alert!"); 
        test.pass("Alert displayed and handled successfully"); 
    } 
 
    @Test 
    public void testDynamicTextChange() { 
        test = extent.createTest("Dynamic Text Change Test"); 
        indexPage.openPage(); 
        String originalText = indexPage.getDynamicText(); 
        indexPage.clickDynamicButton(); 
        String updatedText = indexPage.getDynamicText(); 
        Assert.assertNotEquals(originalText, updatedText, "Text should change after clicking the dynamic button"); 
        test.pass("Text changed successfully"); 
    } 
 
    @AfterClass 
    public void teardown() { 
        extent.flush();
        driver.quit(); 
    } 
}