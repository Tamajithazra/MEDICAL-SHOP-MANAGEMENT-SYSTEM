<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Medicine Orders</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        /* Animated Background */
        body {
            background: linear-gradient(-45deg, #74ebd5, #ACB6E5, #FF9A8B, #ff758c);
            background-size: 400% 400%;
            animation: gradientAnimation 10s ease infinite;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        @keyframes gradientAnimation {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .container {
            max-width: 700px;
            animation: fadeIn 1.5s ease-in-out;
        }

        /* Fade-in Animation */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .card {
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            background: white;
        }

        .form-label {
            font-weight: 600;
        }

        table {
            margin-top: 20px;
        }

        .btn-primary {
            width: 100%;
            font-size: 18px;
        }
    </style>
    <script>
    let totalAmount=0;
    let medicineList=[];
     function fetchMedicineDetails(){
    	 var med=document.getElementById("medicines").value;
    	 if(med)
    	 {
    		 var xhr=new XMLHttpRequest();
    		 xhr.open("GET","XyxServlet?medicineName="+ encodeURIComponent(med),true);
    		 xhr.onreadystatechange=function(){
    			 if(xhr.readyState===4 && xhr.status===200)
    			 {
    				 const obj=JSON.parse(xhr.responseText);
    				 document.getElementById("price").value=obj.price;
    				 document.getElementById("stock").value=obj.stock;
    				 document.getElementById("exp_date").value=obj.expiry_date;
    			 }
    			
    		 };
    		 xhr.send();
    	 }
     }
     function calculateAmount(){
    	 const price=parseInt(document.getElementById("price").value);
    	 const units=parseInt(document.getElementById("units").value);
    	 var amount=price*units;
    	 const med=document.getElementById("medicines").value;
    	 if(med && !isNaN(amount))
    	 {
    		 medicineList.push({name: med,units:units,amount:amount});
    		 const table=document.getElementById("medicine_table");
    		 const row=table.insertRow();
    		 row.insertCell(0).innerHTML=med;
    		 row.insertCell(1).innerHTML=units;
    		 row.insertCell(2).innerHTML="₹"+amount;
    		 totalAmount+=amount;
    		 document.getElementById("amount").value=totalAmount;
    	 }
    	 console.log(medicineList);
     }
     function redirectToAnotherPage(){
    	 
    	 sessionStorage.setItem("medicines",JSON.stringify(medicineList));
    	 sessionStorage.setItem("totalamount",totalAmount);
    	 window.location.href="generator.html";
     }
    </script>
</head>
<body>
	<div class="container">
    <div class="card p-4">
        <h2 class="text-center text-primary">Medicine Purchase</h2>
        
        <form onsubmit="redirectToAnotherPage(); return false;">
            <div class="mb-3">
                <label for="medicines" class="form-label">Select Medicine</label>
                <select class="form-select" id="medicines" onchange="fetchMedicineDetails()">
                    <option value="">-- Select --</option>
                    <%
                        String URL = "jdbc:mysql://localhost:3306/medical_shop";
                        String USER = "root";
                        String PASSWORD = "tamajit";
                        Connection con = null;
                        PreparedStatement ps = null;
                        ResultSet rs = null;
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            con = DriverManager.getConnection(URL, USER, PASSWORD);
                            String query = "SELECT medicine_name FROM medicines";
                            ps = con.prepareStatement(query);
                            rs = ps.executeQuery();
                            while (rs.next()) {
                                String medName = rs.getString("medicine_name");
                    %>
                    <option value="<%= medName %>"><%= medName %></option>
                    <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            try { if (rs != null) rs.close(); } catch (Exception e) {}
                            try { if (ps != null) ps.close(); } catch (Exception e) {}
                            try { if (con != null) con.close(); } catch (Exception e) {}
                        }
                    %>
                </select>
            </div>

            <div class="row">
                <div class="col-md-4 mb-3">
                    <label for="price" class="form-label">Price</label>
                    <input type="text" class="form-control" id="price" readonly>
                </div>
                <div class="col-md-4 mb-3">
                    <label for="stock" class="form-label">Stock</label>
                    <input type="text" class="form-control" id="stock" readonly>
                </div>
                <div class="col-md-4 mb-3">
                    <label for="exp_date" class="form-label">Expiration Date</label>
                    <input type="text" class="form-control" id="exp_date" readonly>
                </div>
            </div>

            <div class="mb-3">
                <label for="units" class="form-label">Units to Purchase</label>
                <input type="number" class="form-control" id="units" min="1" oninput="calculateAmount()">
            </div>

            <table class="table table-bordered table-striped text-center" id="medicine_table">
                <thead class="table-dark">
                    <tr>
                        <th>Medicine Name</th>
                        <th>Units</th>
                        <th>Amount</th>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>

            <div class="mb-3">
                <label for="amount" class="form-label">Total Amount</label>
                <input type="text" class="form-control" id="amount" readonly>
            </div>

            <button type="button" class="btn btn-primary" onclick="redirectToAnotherPage()">Proceed to Payment</button>
        </form>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>