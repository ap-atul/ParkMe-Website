package test;

import org.junit.Test;
import org.junit.Before;
import org.junit.After;
import static org.junit.Assert.*;
import static org.hamcrest.CoreMatchers.is;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.Dimension;
import org.openqa.selenium.JavascriptExecutor;
import java.util.*;

public class SignupwrongphoneTest {
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
	public void signupwrongphone() {
		driver.get("http://localhost:8080/ParkMe/index.jsp");
		driver.manage().window().setSize(new Dimension(1366, 704));
		driver.findElement(By.linkText("Login")).click();
		driver.findElement(By.linkText("Sign Up Here")).click();
		driver.findElement(By.name("name")).click();
		driver.findElement(By.name("name")).sendKeys("AP");
		driver.findElement(By.name("contact")).sendKeys("12345");
		driver.findElement(By.name("city")).sendKeys("Pune");
		driver.findElement(By.cssSelector(".form-group:nth-child(6) .form-control")).sendKeys("atul");
		driver.findElement(By.cssSelector(".form-group:nth-child(5) .form-control")).click();
		driver.findElement(By.cssSelector(".form-group:nth-child(5) .form-control")).sendKeys("atulpatare99@gmail.com");
		driver.findElement(By.cssSelector(".form-group:nth-child(5) .form-control")).sendKeys("atulpatare99@gmail.com");
		driver.findElement(By.id("btn-signup")).click();
		assertThat(driver.findElement(By.cssSelector(".text-center")).getText(),
				is("*** Account Creation Failed. ***"));
	}
}
