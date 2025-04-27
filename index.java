package java_resource;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class index
 */
@WebServlet("/kk")
public class index extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String upass=request.getParameter("pw");
		String uemail=request.getParameter("mail");
		String urole=request.getParameter("medicine");
		try {
			Integer role=Integer.parseInt(urole);
			int k=Validation.checker(upass,uemail,role);
			if(k==0)
			{
				RequestDispatcher rd=request.getRequestDispatcher("IDNOTFOUND.html");
				rd.forward(request, response);
				
			}
			else if(k==1)
			{
				String name=getName(uemail);
				//System.out.println(name);
				request.setAttribute("name",name);
				RequestDispatcher rd=request.getRequestDispatcher("/Wrong");
				rd.forward(request, response);
			}
			else if(k==2)
			{
				String name=getName(uemail);
				request.setAttribute("name", name);
				RequestDispatcher rd=request.getRequestDispatcher("/Wrole");
				rd.forward(request, response);
			}
			else if(k==3)
			{
				RequestDispatcher rd= request.getRequestDispatcher("/user");
				rd.forward(request, response);
			}
			else if(k==4)
			{
				RequestDispatcher rd=request.getRequestDispatcher("/admin");
				rd.forward(request, response);
			}
		}catch(NumberFormatException e)
		{
			PrintWriter p=response.getWriter();
			p.println("enter integer  value as role");
		}
	}
	
	String getName(String email)
	{
		try {
			Connection con=MyConnection.connector();
			String query="select name from users where email=?";
			PreparedStatement ps=con.prepareStatement(query);
			ps.setString(1,email);
			ResultSet rs=ps.executeQuery();
			if(rs.next()==true)
			{
				String name=rs.getString("name");
				return name;
			}
		}catch(SQLException e)
		{
			e.printStackTrace();
		}
		return "";
	}

}
