<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Available Medicines</title>
  <style>
    * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Poppins', sans-serif;
}

body {
    background: linear-gradient(-45deg, #74ebd5, #ACB6E5, #FF9A8B, #ff758c);
    background-size: 400% 400%;
    animation: gradientAnimation 10s ease infinite;
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-direction: column;
    padding-top: 70px; /* Ensures navbar does not overlap content */
}

@keyframes gradientAnimation {
    0% { background-position: 0% 50%; }
    50% { background-position: 100% 50%; }
    100% { background-position: 0% 50%; }
}

.navbar {
    background: #2C3E50;
    padding: 15px 50px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    color: white;
    width: 100%;
    position: fixed;
    top: 0;
    left: 0;
    box-shadow: 0 4px 10px rgba(0,0,0,0.2);
    z-index: 1000;
}

.navbar h2 {
    margin: 0;
}

.nav-links {
    list-style: none;
    display: flex;
    gap: 20px;
}

.nav-links li {
    display: inline;
}

.nav-links a {
    color: white;
    text-decoration: none;
    font-weight: 500;
    transition: color 0.3s;
}

.nav-links a:hover {
    color: #1abc9c;
}

.medicine-container {
    width: 90vw;
    padding: 20px;
    background: rgba(255, 255, 255, 0.2);
    backdrop-filter: blur(10px);
    display: flex;
    justify-content: center;
    align-items: flex-start;
    flex-direction: column;
    margin-top: 20px; /* Space below navbar */
}

.medicine-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    gap: 20px;
    width: 90%;
    max-width: 1200px;
    align-items: start; /* Ensures medicine boxes align properly */
}

.medicine-box {
    background: rgba(255, 255, 255, 0.9);
    padding: 20px;
    border-radius: 15px;
    box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
    text-align: center;
    transition: transform 0.3s, box-shadow 0.3s;
    min-height: 150px; /* Ensures consistent box height */
}

.medicine-box:hover {
    transform: translateY(-5px);
    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
}

.medicine-box h2 {
    font-size: 20px;
    color: #1abc9c;
    margin-bottom: 10px; /* Ensures spacing */
}

.medicine-box h3 {
    font-size: 16px;
    color: #333;
}

</style>
</head>
<body>

	<nav class="navbar">
        <h2>MEDICAL SHOP</h2>
        <ul class="nav-links">
            <li><a href="myuser.html">DASHBOARD</a></li>
            <li><a href="#">ADD MEDICINES</a></li>
            <li><a href="#">USERS</a></li>
            <li><a href="#">SETTINGS</a></li>
        </ul>
    </nav>
	<div class="medicine-container">
		<div class="medicine-grid">
		<%
			String URL="jdbc:mysql://localhost:3306/medical_shop";
			String USER="root";
			String PASSWORD="tamajit";
			Connection con=null;
			PreparedStatement ps=null;
			ResultSet rs=null;
			try{
				Class.forName("com.mysql.cj.jdbc.Driver");
				con=DriverManager.getConnection(URL,USER,PASSWORD);
				String query="select * from medicines";
				ps=con.prepareStatement(query);
				rs=ps.executeQuery();
				while(rs.next())
				{
					String medName=rs.getString("medicine_name");
					int stock=rs.getInt("stock");
					int price=rs.getInt("price");
					java.sql.Date expdate=rs.getDate("exp_date");
					
		%>
					<div class="medicine-box"><h2><%= medName %></h2><br>
					<h3> Price: <%= price%></h3> <h3> Stock: <%= stock %></h3><br>
					<h3> Expiry: <%= expdate%></h3>
					</div>
		<%		}
			}catch(Exception e)
			{
				e.printStackTrace();
			}
			finally{
				try{
					if(con!=null)
						con.close();
					if(ps!=null)
						ps.close();
					if(rs!=null)
						rs.close();
				}catch(Exception e)
				{
					e.printStackTrace();
				}
			}
				%>
		</div>
	</div>
</body>
</html>