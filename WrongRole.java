package java_resource;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class WrongRole
 */
@WebServlet("/Wrole")
public class WrongRole extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    String mail = request.getParameter("mail");
	    response.setContentType("text/html");
	    PrintWriter p = response.getWriter();
	    String name=getName(mail);
	    p.println("<!DOCTYPE html>");
	    p.println("<html>");
	    p.println("<head>");
	    p.println("<meta charset='UTF-8'>");
	    p.println("<title>Medical Shop - Error</title>");
	    p.println("<style>");
	    p.println("body {");
	    p.println("    margin: 0;");
	    p.println("    padding: 0;");
	    p.println("    height: 100vh;");
	    p.println("    display: flex;");
	    p.println("    justify-content: center;");
	    p.println("    align-items: center;");
	    p.println("    font-family: Arial, sans-serif;");
	    p.println("    background: linear-gradient(to right, #87CEEB, #ffffff);");
	    p.println("}");
	    p.println(".error-container {");
	    p.println("    background: white;");
	    p.println("    padding: 30px;");
	    p.println("    border-radius: 10px;");
	    p.println("    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);");
	    p.println("    text-align: center;");
	    p.println("    animation: fadeIn 1s ease-in;");
	    p.println("}");
	    p.println("h1 {");
	    p.println("    color: #2c3e50;");
	    p.println("}");
	    p.println("a {");
	    p.println("    display: inline-block;");
	    p.println("    margin-top: 10px;");
	    p.println("    padding: 10px 15px;");
	    p.println("    background: #3498db;");
	    p.println("    color: white;");
	    p.println("    text-decoration: none;");
	    p.println("    border-radius: 5px;");
	    p.println("    transition: 0.3s;");
	    p.println("}");
	    p.println("a:hover {");
	    p.println("    background: #2980b9;");
	    p.println("}");
	    p.println("@keyframes fadeIn {");
	    p.println("    from { opacity: 0; transform: translateY(-20px); }");
	    p.println("    to { opacity: 1; transform: translateY(0); }");
	    p.println("}");
	    p.println("</style>");
	    p.println("</head>");
	    p.println("<body>");
	    p.println("    <div class='error-container'>");
	    p.println("        <h1><b>" + name + " YOU HAVE ENTERED WRONG ROLE</b></h1>");
	    p.println("        <h1><b>PLEASE TRY AGAIN WITH CORRECT ROLE</b></h1>");
	    p.println("        <a href='index.html'>GO BACK TO LOGIN PAGE</a>");
	    p.println("    </div>");
	    p.println("</body>");
	    p.println("</html>");
	}
	String getName(String email)
	{
		String URL="jdbc:mysql://localhost:3306/medical_shop";
		String USERS="root";
		String PASSWORD="tamajit";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String query="select name from users where email=?";
			Connection con=DriverManager.getConnection(URL,USERS,PASSWORD);
			PreparedStatement ps=con.prepareStatement(query);
			ps.setString(1, email);
			ResultSet rs=ps.executeQuery();
			if(rs.next())
			{
				String name=rs.getString("name");
				return name;
			}
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return "";
		
	}
}
