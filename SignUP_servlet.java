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
 * Servlet implementation class SignUP_servlet
 */
@WebServlet("/signup")
public class SignUP_servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email=request.getParameter("mail");
		String name=request.getParameter("name");
		String password=request.getParameter("pw");
		int role=Integer.parseInt(request.getParameter("role"));
		//System.out.println(email+" "+name+" "+password+" "+role);
		String URL="jdbc:mysql://localhost:3306/medical_shop";
		String PASSWORD="tamajit";
		String USERS="root";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con=DriverManager.getConnection(URL,USERS,PASSWORD);
			String query="insert into users value(?,?,?,?)";
			PreparedStatement ps=con.prepareStatement(query);
			ps.setString(1,email);
			ps.setString(2,name);
			ps.setString(3,password);
			ps.setInt(4, role);
			int rs=ps.executeUpdate();
			if(rs==1)
			{
				response.setContentType("text/html");
				PrintWriter p=response.getWriter();
				 p.println("<!DOCTYPE html>");
				    p.println("<html lang='en'>");
				    p.println("<head>");
				    p.println("<meta charset='UTF-8'>");
				    p.println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
				    p.println("<title>Signup Success</title>");
				    p.println("<style>");
				    p.println("body { font-family: Arial, sans-serif; background: linear-gradient(to right, #87CEEB, #ffffff); display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }");
				    p.println(".container { background: white; padding: 30px; border-radius: 10px; box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2); text-align: center; animation: fadeIn 1s ease-in; }");
				    p.println("h2 { color: #2c3e50; }");
				    p.println("a { display: inline-block; margin-top: 15px; padding: 10px 20px; background: #3498db; color: white; text-decoration: none; font-size: 16px; border-radius: 5px; transition: 0.3s; }");
				    p.println("a:hover { background: #2980b9; }");
				    p.println("@keyframes fadeIn { from { opacity: 0; transform: translateY(-20px); } to { opacity: 1; transform: translateY(0); } }");
				    p.println("</style>");
				    p.println("</head>");
				    p.println("<body>");
				    p.println("<div class='container'>");
				    p.println("<h2>YOU HAVE SUCCESSFULLY SIGNED-UP</h2>");
				    p.println("<a href='index.html'>CLICK TO LOGIN</a>");
				    p.println("</div>");
				    p.println("</body>");
				    p.println("</html>");
			}
			else {
				PrintWriter p=response.getWriter();
				 p.println("<!DOCTYPE html>");
				    p.println("<html lang='en'>");
				    p.println("<head>");
				    p.println("<meta charset='UTF-8'>");
				    p.println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
				    p.println("<title>Signup Success</title>");
				    p.println("<style>");
				    p.println("body { font-family: Arial, sans-serif; background: linear-gradient(to right, #87CEEB, #ffffff); display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }");
				    p.println(".container { background: white; padding: 30px; border-radius: 10px; box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2); text-align: center; animation: fadeIn 1s ease-in; }");
				    p.println("h2 { color: #2c3e50; }");
				    p.println("a { display: inline-block; margin-top: 15px; padding: 10px 20px; background: #3498db; color: white; text-decoration: none; font-size: 16px; border-radius: 5px; transition: 0.3s; }");
				    p.println("a:hover { background: #2980b9; }");
				    p.println("@keyframes fadeIn { from { opacity: 0; transform: translateY(-20px); } to { opacity: 1; transform: translateY(0); } }");
				    p.println("</style>");
				    p.println("</head>");
				    p.println("<body>");
				    p.println("<div class='container'>");
				    p.println("<h2>ERROR OCCURED AT THE TIME OF SIGN UP TRY AGAIN!</h2>");
				    p.println("<a href='signup_page.html'>CLICK TO LOGIN</a>");
				    p.println("</div>");
				    p.println("</body>");
				    p.println("</html>");
			}
		}catch(Exception e)
		{
			e.printStackTrace();
		}
	}

}
