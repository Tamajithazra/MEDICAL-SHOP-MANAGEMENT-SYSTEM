<%@ page import="java.time.LocalDate" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Available Medicines</title>
<style>
    * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Poppins', sans-serif; }
    body { background: linear-gradient(-45deg, #74ebd5, #ACB6E5, #FF9A8B, #ff758c); background-size: 400% 400%; animation: gradientAnimation 10s ease infinite; min-height: 100vh; display: flex; align-items: center; justify-content: center; flex-direction: column; padding-top: 70px; }
    @keyframes gradientAnimation { 0% { background-position: 0% 50%; } 50% { background-position: 100% 50%; } 100% { background-position: 0% 50%; } }
    .navbar { background: #2C3E50; padding: 15px 50px; display: flex; justify-content: space-between; align-items: center; color: white; width: 100%; position: fixed; top: 0; left: 0; box-shadow: 0 4px 10px rgba(0,0,0,0.2); z-index: 1000; }
    .navbar h2 { margin: 0; }
    .nav-links { list-style: none; display: flex; gap: 20px; }
    .nav-links li { display: inline; }
    .nav-links a { color: white; text-decoration: none; font-weight: 500; transition: color 0.3s; }
    .nav-links a:hover { color: #1abc9c; }
    .medicine-container { width: 90vw; padding: 20px; background: rgba(255, 255, 255, 0.2); backdrop-filter: blur(10px); display: flex; justify-content: center; align-items: flex-start; flex-direction: column; margin-top: 20px; }
    .medicine-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 20px; width: 90%; max-width: 1200px; align-items: start; }
    .medicine-box { background: rgba(255, 255, 255, 0.9); padding: 20px; border-radius: 15px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1); text-align: center; transition: transform 0.3s, box-shadow 0.3s; min-height: 150px; }
    .medicine-box:hover { transform: translateY(-5px); box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2); }
    .medicine-box h2 { font-size: 20px; color: #1abc9c; margin-bottom: 10px; }
    .medicine-box h3 { font-size: 16px; color: #333; }
</style>
</head>
<body>

<nav class="navbar">
    <h2>MEDICAL SHOP</h2>
    <ul class="nav-links">
        <li><a href="myuser.html">DASHBOARD</a></li>
        <li><a href="#">ORDER HISTORY</a></li>
        <li><a href="Users.jsp">USERS</a></li>
        <li><a href="index.html">LOG-OUT</a></li>
    </ul>
</nav>

<div class="medicine-container">
    <div class="medicine-grid">
       <%
    String URL = "jdbc:mysql://localhost:3306/medical_shop";
    String USER = "root";
    String PASSWORD = "tamajit";
    Connection con = null;
    PreparedStatement psSelect = null, psInsert = null, psDelete = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(URL, USER, PASSWORD);
        String query = "SELECT * FROM medicines";
        psSelect = con.prepareStatement(query);
        rs = psSelect.executeQuery();
        LocalDate today = LocalDate.now();

        while (rs.next()) {
            String medName = rs.getString("medicine_name");
            int stock = rs.getInt("stock");
            int price = rs.getInt("price");
            java.sql.Date expDate = rs.getDate("exp_date");

            if (expDate.toLocalDate().isBefore(today)) {
                // Insert into expired_medicines table
                String queryInsert = "INSERT INTO expried_medicines (medicine_name, stock, price, exp_date) VALUES (?, ?, ?, ?)";
                psInsert = con.prepareStatement(queryInsert);
                psInsert.setString(1, medName);
                psInsert.setInt(2, stock);
                psInsert.setInt(3, price);
                psInsert.setDate(4, expDate);
                psInsert.executeUpdate();

                // Delete from medicines table
                String queryDelete = "DELETE FROM medicines WHERE medicine_name = ? AND exp_date = ?";
                psDelete = con.prepareStatement(queryDelete);
                psDelete.setString(1, medName);
                psDelete.setDate(2, expDate);
                psDelete.executeUpdate();
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (psSelect != null) psSelect.close();
            if (psInsert != null) psInsert.close();
            if (psDelete != null) psDelete.close();
            if (con != null) con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>

        
     <%
    Connection con2 = null;
    PreparedStatement psFounder = null;
    ResultSet rs2 = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con2 = DriverManager.getConnection(URL, USER, PASSWORD);
        String queryFinder = "SELECT * FROM expried_medicines";
        psFounder = con2.prepareStatement(queryFinder);
        rs2 = psFounder.executeQuery();
        
        while (rs2.next()) { // changed from if(...) to while(...) to show multiple boxes
            String namemed = rs2.getString("medicine_name");
            int stock2 = rs2.getInt("stock");
            int price2 = rs2.getInt("price");
            java.sql.Date expdate = rs2.getDate("exp_date");
%>
            <div class="medicine-box">
                <h2><%= namemed %></h2><br>
                <h3> Price: <%= price2 %></h3> 
                <h3> Stock: <%= stock2 %></h3><br>
                <h3> Expiry: <%= expdate %></h3>
            </div>
<% 
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs2 != null) rs2.close();
            if (psFounder != null) psFounder.close();
            if (con2 != null) con2.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>
    </div>
</div>

</body>
</html>
