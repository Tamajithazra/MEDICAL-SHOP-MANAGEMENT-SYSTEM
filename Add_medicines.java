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
 * Servlet implementation class Add_medicines
 */
@WebServlet("/add")
public class Add_medicines extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name=request.getParameter("name");
		String stock=request.getParameter("stock");
		String price=request.getParameter("price");
		String URL="jdbc:mysql://localhost:3306/medical_shop";
		String USER="root";
		String PASSWORD="tamajit";
		try {
			String exp=request.getParameter("exp_date");
			java.sql.Date sqlDate=java.sql.Date.valueOf(exp);
			Connection con=DriverManager.getConnection(URL,USER,PASSWORD);
			String query="insert into medicines values(?,?,?,?)";
			PreparedStatement ps=con.prepareStatement(query);
			ps.setString(1,name);
			ps.setString(2,stock);
			ps.setString(3,price);
			ps.setDate(4, sqlDate);
			int rs=ps.executeUpdate();
			if(rs>0)
			{
				PrintWriter out=response.getWriter();
				out.println("<script type=\"text/javascript\">");
				out.println("alert(\"MEDICINE ADDED SUCCESSFULLY\");");
				out.println("location='ADMIN_PAGE.html'");
				out.println("</script");
			}
		}catch(Exception e)
		{
			e.printStackTrace();
		}
	}

}
