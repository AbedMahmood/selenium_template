package utils; 
 
import org.openqa.selenium.WebDriver; 
import org.openqa.selenium.edge.EdgeDriver; 
import io.github.bonigarcia.wdm.WebDriverManager; 
 
public class BrowserSetup { 
    public static WebDriver getDriver() { 
        WebDriverManager.edgedriver().setup(); 
        WebDriver driver = new EdgeDriver(); 
        driver.manage().window().maximize(); 
        return driver; 
    } 
}