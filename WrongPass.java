package java_resource;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Wrong")
public class WrongPass extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        String name = (String) request.getAttribute("name");
	        response.setContentType("text/html");
	        PrintWriter p = response.getWriter();

	        p.println("<!DOCTYPE html>");
	        p.println("<html>");
	        p.println("<head>");
	        p.println("<meta charset='UTF-8'>");
	        p.println("<title>Medical Shop - Wrong Password</title>");
	        p.println("<style>");
	        p.println("body {");
	        p.println("    margin: 0; padding: 0; height: 100vh; display: flex; justify-content: center; align-items: center;");
	        p.println("    font-family: Arial, sans-serif; background: linear-gradient(to right, #ff6b6b, #ff4757);");
	        p.println("}");
	        p.println(".error-container {");
	        p.println("    background: white; padding: 30px; border-radius: 10px;");
	        p.println("    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2); text-align: center; animation: fadeIn 1s ease-in;");
	        p.println("}");
	        p.println("h1 {");
	        p.println("    color: #2c3e50;");
	        p.println("}");
	        p.println("a {");
	        p.println("    display: inline-block; margin-top: 10px; padding: 10px 15px; background: #e74c3c;");
	        p.println("    color: white; text-decoration: none; border-radius: 5px; transition: 0.3s;");
	        p.println("}");
	        p.println("a:hover {");
	        p.println("    background: #c0392b;");
	        p.println("}");
	        p.println("@keyframes fadeIn {");
	        p.println("    from { opacity: 0; transform: translateY(-20px); }");
	        p.println("    to { opacity: 1; transform: translateY(0); }");
	        p.println("}");
	        p.println("</style>");
	        p.println("</head>");
	        p.println("<body>");
	        p.println("    <div class='error-container'>");
	        p.println("        <h1><b>" + name + ", YOU HAVE ENTERED WRONG PASSWORD</b></h1>");
	        p.println("        <h1><b>PLEASE TRY AGAIN WITH CORRECT PASSWORD</b></h1>");
	        p.println("        <a href='index.html'>GO BACK TO LOGIN PAGE</a>");
	        p.println("    </div>");
	        p.println("</body>");
	        p.println("</html>");
	    }
	}

