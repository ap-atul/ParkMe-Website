package test;

import org.junit.Test;

import org.junit.Before;
import org.junit.After;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.Dimension;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.JavascriptExecutor;
import java.util.*;

public class ContactpagetestTest {
	private WebDriver driver;
	private Map<String, Object> vars;
	JavascriptExecutor js;

	@Before
	public void setUp() {
		driver = new FirefoxDriver();
		js = (JavascriptExecutor) driver;
		vars = new HashMap<String, Object>();
	}

	@After
	public void tearDown() {
		driver.quit();
	}

	@Test
	public void contactpagetest() {
		driver.get("http://localhost:8080/ParkMe/index.jsp");
		driver.manage().window().setSize(new Dimension(1280, 720));
		driver.findElement(By.name("fname")).click();
		driver.findElement(By.name("fname")).sendKeys("as");
		driver.findElement(By.name("lname")).click();
		driver.findElement(By.name("lname")).sendKeys("aa");
		driver.findElement(By.name("email")).click();
		driver.findElement(By.name("email")).sendKeys("ap@gmail.com");
		driver.findElement(By.name("message")).click();
		{
			WebElement element = driver.findElement(By.cssSelector(".btn-block"));
			Actions builder = new Actions(driver);
			builder.moveToElement(element).perform();
		}
		driver.findElement(By.name("message")).sendKeys("aaa");
		driver.findElement(By.cssSelector(".btn-block")).click();
		{
			WebElement element = driver.findElement(By.tagName("body"));
			Actions builder = new Actions(driver);
			builder.moveToElement(element, 0, 0).perform();
		}
	}
}
