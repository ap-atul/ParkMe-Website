package test;

import org.junit.Test;
import org.junit.Before;
import org.junit.After;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.Dimension;
import org.openqa.selenium.JavascriptExecutor;
import java.util.*;

public class AddnewcarTest {
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
	public void addnewcar() {
		driver.get("http://localhost:8080/ParkMe/index.jsp");
		driver.manage().window().setSize(new Dimension(1280, 720));
		driver.findElement(By.linkText("Login")).click();
		driver.findElement(By.id("login-username")).click();
		driver.findElement(By.id("login-username")).sendKeys("atulpatare99@gmail.com");
		driver.findElement(By.id("login-password")).sendKeys("atul");
		driver.findElement(By.id("btn-signin")).click();
		driver.findElement(By.cssSelector(".badge")).click();
		driver.findElement(By.name("inputName")).click();
		driver.findElement(By.name("inputName")).sendKeys("Mercedes Benz");
		driver.findElement(By.name("inputPlate")).click();
		driver.findElement(By.name("inputPlate")).sendKeys("NH 17 1234");
		driver.findElement(By.cssSelector(".btn")).click();
	}
}
