package db;

import java.sql.Connection;
import java.sql.DriverManager;

public class InitDB {
	public static Connection getConnection(){
		Connection con=null;
		try{ 
		    Class.forName("com.mysql.jdbc.Driver");  
		    con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/parkme?useSSL=false","root","root");
		   
	    }catch(Exception e){ System.out.println(e);}
		return con;
	}
}