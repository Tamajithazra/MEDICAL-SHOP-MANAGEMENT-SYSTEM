<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEDICAL SHOP </title>
<style>
    body {
        font-family: Arial, sans-serif;
        background: linear-gradient(270deg, #ff9a9e, #fad0c4);
        background-size: 400% 400%;
        animation: bgAnimation 10s ease infinite;
        margin: 0;
        padding: 0;
    }
    @keyframes bgAnimation {
        0% { background-position: 0% 50%; }
        50% { background-position: 100% 50%; }
        100% { background-position: 0% 50%; }
    }
    .navbar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 15px 30px;
        background: #2c3e50;
        color: white;
        box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.3);
    }
    .navbar h2 {
        margin: 0;
    }
    .navbar ul {
        list-style: none;
        display: flex;
        padding: 0;
    }
    .navbar ul li {
        margin-left: 20px;
    }
    .navbar ul li a {
        text-decoration: none;
        color: white;
        font-weight: bold;
        transition: color 0.3s;
    }
    .navbar ul li a:hover {
        color: #f1c40f;
    }
    .leaderboard {
        max-width: 600px;
        margin: 50px auto;
        padding: 20px;
        background: white;
        border-radius: 10px;
        box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
    }
    .leaderboard h2 {
        text-align: center;
    }
    .user {
        display: flex;
        justify-content: space-between;
        padding: 10px;
        border-bottom: 1px solid #ddd;
    }
    .user:last-child {
        border-bottom: none;
    }
</style>
</head>
<body>
	<nav class="navbar">
		<h2>MEDICAL SHOP</h2>
		<ul class="nav links">
		<li><a href="myuser.html">DASHBOARD</a></li>
        <li><a href="#">ORDER HISTORY</a></li>
        <li><a href="Users.jsp">USERS</a></li>
        <li><a href="index.html">LOG-OUT</a></li>
		</ul>
	</nav>
	
	<%	
		String URL="jdbc:mysql://localhost:3306/medical_shop";
		String USERS="root";
		String PASSWORD="tamajit";
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		try{
			Class.forName("com.mysql.cj.jdbc.Driver");
			con=DriverManager.getConnection(URL,USERS,PASSWORD);
			String query="select * from users where role=?";
			ps=con.prepareStatement(query);
			ps.setInt(1,0);
			rs=ps.executeQuery();
			while(rs.next())
			{
					String name=rs.getString("name");
	%>
				<div align="center">
					<h2><%= name%></h2>
				</div>
				<br>
	<%      }	
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
				
			}
		}
	
	%>
</body>
</html>