package java_resource;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Validation {
	static int checker(String pass,String email,int role)
	{
		try {
			Connection con=MyConnection.connector();
			String query="select * from users where email=?";
			PreparedStatement ps=con.prepareStatement(query);
			ps.setString(1,email.trim());
			ResultSet rs=ps.executeQuery();
			if(rs.next()==true)
			{
				String dbpass=rs.getString("password");
				int dbrole=rs.getInt("role");
				if(!dbpass.equals(pass))
				{
					return 1;
				}
				else if(dbpass.equals(pass) && dbrole!=role)
				{
					return 2;
				}
				else if(dbpass.equals(pass)&& dbrole==1)
				{
					return 4;
				}
				else if(dbpass.equals(pass)&& dbrole==0)
					return 3;
			}
			else
			{
				return 0;
			}
		}catch(SQLException e)
		{
			System.out.println(" SQL EXCEPPTION OCCURES");
		}
		return 0;
	}
}
