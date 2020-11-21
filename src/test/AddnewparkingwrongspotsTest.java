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
import org.openqa.selenium.Keys;
import java.util.*;


public class AddnewparkingwrongspotsTest {
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
	public void addnewparkingwrongspots() {
		driver.get("http://localhost:8080/ParkMe/index.jsp");
		driver.manage().window().setSize(new Dimension(670, 625));
		driver.findElement(By.cssSelector(".navbar-toggler-icon")).click();
		driver.findElement(By.linkText("Login")).click();
		driver.findElement(By.id("login-username")).click();
		driver.findElement(By.id("login-username")).sendKeys("atulpatare99@gmail.com");
		driver.findElement(By.id("login-password")).sendKeys("atul");
		driver.findElement(By.id("login-password")).sendKeys(Keys.ENTER);
		driver.findElement(By.cssSelector(".nav > .nav-item:nth-child(2) > .nav-link")).click();
		driver.findElement(By.linkText("Click here to add new parking")).click();
		driver.findElement(By.name("inputName")).click();
		driver.findElement(By.name("inputName")).click();
		driver.findElement(By.name("inputName")).sendKeys("AP");
		driver.findElement(By.name("inputEmail")).sendKeys("atulpatare99.gmail.com");
		driver.findElement(By.name("inputContact")).sendKeys("1234567890");
		driver.findElement(By.name("inputSpots")).sendKeys("-1");
		driver.findElement(By.name("inputFare")).sendKeys("1234");
		driver.findElement(By.name("inputPlaceName")).sendKeys("Shopping Mall");
		driver.findElement(By.name("inputAddress")).sendKeys("1234 Main St");
		driver.findElement(By.name("inputAddress2")).sendKeys("Apartment, behind road 1");
		driver.findElement(By.name("inputCity")).sendKeys("Pune");
		driver.findElement(By.name("inputState")).sendKeys("Maharashtra");
		driver.findElement(By.name("inputZip")).sendKeys("123333");
		driver.findElement(By.id("image")).sendKeys(Keys.ENTER);
		driver.findElement(By.name("inputZip")).sendKeys("123123");
		driver.findElement(By.cssSelector(".btn")).click();
		assertThat(driver.findElement(By.cssSelector(".text-center")).getText(), is("*** Parking Creation Failed ***"));
	}
}
