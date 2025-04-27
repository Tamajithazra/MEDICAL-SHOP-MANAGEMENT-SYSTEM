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
 * Servlet implementation class XyxServlet
 */
@WebServlet("/XyxServlet")
public class XyxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String medicineName=request.getParameter("medicineName");
		response.setContentType("application/json");
		PrintWriter out=response.getWriter();
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		String URL="jdbc:mysql://localhost:3306/medical_shop";
		String USERS="root";
		String PASSWORD="tamajit";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con=DriverManager.getConnection(URL,USERS,PASSWORD);
			String query="select stock,price,exp_date from  medicines where medicine_name=?";
			ps=con.prepareStatement(query);
			ps.setString(1,medicineName);
			rs=ps.executeQuery();
			if(rs.next())
			{
				int price=rs.getInt("price");
				int stock=rs.getInt("stock");
				java.sql.Date expdate=rs.getDate("exp_date");
				String jsonresponseString =String.format("{\"price\":%d,\"stock\":%d,\"expiry_date\":\"%s\"}", price, stock, expdate);
				out.println(jsonresponseString);
			}else
			{
				String jsonresponseString =String.format("{\"price\":0,\"stock\":0,\"expiry_date\":}");
				out.println(jsonresponseString);
			}
		}catch(Exception e)
		{
			 e.printStackTrace();
	         out.print("{\"error\": \"An error occurred while fetching medicine details.\"}");
		}
		finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
		out.flush();
	}

}
