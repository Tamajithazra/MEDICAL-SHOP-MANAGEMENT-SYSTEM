<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ADD NEW MEDICINES</title>
<style>
/* Animated Background */
body {
    background: linear-gradient(-45deg, #74ebd5, #ACB6E5, #FF9A8B, #ff758c);
    background-size: 400% 400%;
    animation: gradientAnimation 10s ease infinite;
    margin: 0;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

@keyframes gradientAnimation {
    0% { background-position: 0% 50%; }
    50% { background-position: 100% 50%; }
    100% { background-position: 0% 50%; }
}

/* Navbar Styles */
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
    box-sizing: border-box;
}

.navbar h2 {
    margin: 0;
}

.nav-links {
    list-style: none;
    display: flex;
    gap: 20px;
    margin: 0;
    padding: 0;
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

/* Container for the form */
.container {
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
    padding-top: 120px; /* ensures space below navbar */
    box-sizing: border-box;
    flex-direction: column;
    animation: fadeIn 1.5s ease-in-out;
}

/* Fade-in Animation */
@keyframes fadeIn {
    from { opacity: 0; transform: translateY(-20px); }
    to { opacity: 1; transform: translateY(0); }
}

/* Form Table Styling */
table {
    background-color: rgba(255, 255, 255, 0.9);
    padding: 30px;
    border-radius: 15px;
    box-shadow: 0px 8px 20px rgba(0, 0, 0, 0.2);
    border-collapse: separate;
    border-spacing: 15px;
    width: 100%;
    max-width: 500px;
}

td {
    font-size: 16px;
    font-weight: 500;
    color: #333;
}

/* Input Fields */
input[type="text"],
input[type="date"] {
    width: 100%;
    padding: 10px 12px;
    font-size: 15px;
    border: 1px solid #ccc;
    border-radius: 8px;
    outline: none;
    transition: border-color 0.3s ease, box-shadow 0.3s ease;
}

input[type="text"]:focus,
input[type="date"]:focus {
    border-color: #74ebd5;
    box-shadow: 0 0 8px rgba(116, 235, 213, 0.5);
}

/* Submit Button */
input[type="submit"] {
    background-color: #74ebd5;
    border: none;
    padding: 12px 20px;
    color: #fff;
    font-size: 16px;
    font-weight: bold;
    border-radius: 8px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

input[type="submit"]:hover {
    background-color: #4ecdc4;
}

td[colspan="2"] {
    padding-top: 10px;
}
</style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar">
    <h2>MEDICAL SHOP</h2>
    <ul class="nav-links">
        <li><a href="myuser.html">DASHBOARD</a></li>
        <li><a href="Addmedicines.jsp">ADD MEDICINES</a></li>
        <li><a href="Users.jsp">USERS</a></li>
        <li><a href="#">SETTINGS</a></li>
    </ul>
</nav>

<!-- Form Container -->
<div class="container">
    <form action="add" method="post">
        <table>
            <tr>
                <td>:ENTER THE NAME OF MEDICNINE:</td>
                <td><input type="text" name="name" required></td>
            </tr>
            <tr>
                <td>:ENTER MARKED PRICE(INCLUDING TAXS):</td>
                <td><input type="text" name="price" required></td>
            </tr>
            <tr>
                <td>:ENTER THE STOCK OF THE MEDICINE:</td>
                <td><input type="text" name="stock" required></td>
            </tr>
            <tr>
                <td>:ENTER THE EXPIRED DATE:</td>
                <td><input type="date" name="exp_date" required></td>
            </tr>
            <tr>
                <td colspan="2" align="center"><input type="submit" value="ADD"></td>
            </tr>
        </table>
    </form>
</div>

</body>
</html>
