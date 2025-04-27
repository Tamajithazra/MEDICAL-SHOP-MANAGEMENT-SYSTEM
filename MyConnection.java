package java_resource;

import java.sql.Connection;
import java.sql.DriverManager;

public class MyConnection {
	
	public static Connection connector()
	{
		 final String URL="jdbc:mysql://localHost:3306/medical_shop";
		 final String ID="root";
		 final String PASSWORD="tamajit";
		 Connection con=null;
		 try {
			 con=DriverManager.getConnection(URL,ID,PASSWORD);
		 }catch(Exception e)
		 {
			e.printStackTrace();
		 }
		 if (con == null) {
			    System.out.println("Database connection failed.");
			}
		 return con;
	}
}
