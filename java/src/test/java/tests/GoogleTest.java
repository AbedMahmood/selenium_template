package tests; 
 
import com.aventstack.extentreports.ExtentReports; 
import com.aventstack.extentreports.ExtentTest; 
import com.aventstack.extentreports.reporter.ExtentSparkReporter; 
import org.openqa.selenium.WebDriver; 
import org.testng.Assert; 
import org.testng.annotations.AfterClass; 
import org.testng.annotations.BeforeClass; 
import org.testng.annotations.Test; 
import utils.BrowserSetup; 
import pages.GooglePage; 
 
public class GoogleTest { 
    WebDriver driver; 
    GooglePage google; 
    ExtentReports extent; 
    ExtentTest test; 
 
    @BeforeClass 
    public void setup() { 
        driver = BrowserSetup.getDriver(); 
        google = new GooglePage(driver); 
 
        // Initialize Extent Report for HTML output 
        ExtentSparkReporter sparkReporter = new ExtentSparkReporter("reports/GoogleReport.html"); 
        extent = new ExtentReports(); 
        extent.attachReporter(sparkReporter); 
    } 
 
    @Test 
    public void testGoogleTitle() { 
        test = extent.createTest("Google Test"); 
        driver.get("https://www.google.com"); 
        Assert.assertTrue(driver.getTitle().contains("Google")); 
        test.pass("Visited Google successfully"); 
    } 
 
    @AfterClass 
    public void teardown() { 
        extent.flush();
        driver.quit(); 
    } 
}