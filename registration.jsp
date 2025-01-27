<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Registration Form</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 20px;
        }
        label {
            font-size: 14px;
        }
        input {
            margin-bottom: 10px;
            padding: 8px;
            width: 300px;
        }
        button {
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
        }
    </style>
</head>
<body>
<div>
    <h2>Voter Registration Form</h2>
<form action="registration.jsp" method="post">
    <input type="hidden" name="action" value="add">
    
    <label for="full_name">Full Name:</label><br>
    <input type="text" id="fullName" name="full_name" required><br>
    
    <label for="father_name">Father's Name:</label><br>
    <input type="text" id="fatherName" name="father_name" required><br>
    
    <label for="mobile_number">Mobile Number:</label><br>
    <input type="text" id="mobileNumber" name="mobile_number" required><br>
    
    <label for="aadhar_card">Aadhar Card:</label><br>
    <input type="text" id="aadharCard" name="aadhar_card" required><br>
    
    <label for="pancard">Pan Card:</label><br>
    <input type="text" id="pancard" name="pancard" required><br>
    
    <label for="dob">Date of Birth:</label><br>
    <input type="date" id="dobString" name="dob" required><br>
    
    <label for="blood_group">Blood Group:</label><br>
    <input type="text" id="bloodGroup" name="blood_group" required><br><br>
    
    <button type="submit">Submit</button>
</form>

    
   <%
if ("POST".equalsIgnoreCase(request.getMethod())) {
    String action = request.getParameter("action");

    if ("add".equalsIgnoreCase(action)) {
        String fullName = request.getParameter("full_name");
        String fatherName = request.getParameter("father_name");
        String mobileNumber = request.getParameter("mobile_number");
        String aadharCard = request.getParameter("aadhar_card");
        String pancard = request.getParameter("pancard");
        String dobString = request.getParameter("dob"); // Date from the form (String)
        String bloodGroup = request.getParameter("blood_group");

        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinevoting", "root", "root");
            // Parse the date from String to java.sql.Date
            java.sql.Date dob = null;
            if (dobString != null && !dobString.isEmpty()) {
                java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
                java.util.Date parsedDate = sdf.parse(dobString);
                dob = new java.sql.Date(parsedDate.getTime());
            }

            // Prepare the SQL query
            String query = "INSERT INTO voterusers (full_name, father_name, mobile_number, aadhar_card, pancard, dob, blood_group) VALUES (?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement pstmt = con.prepareStatement(query)) {
                pstmt.setString(1, fullName);
                pstmt.setString(2, fatherName);
                pstmt.setString(3, mobileNumber);
                pstmt.setString(4, aadharCard);
                pstmt.setString(5, pancard);
                pstmt.setDate(6, dob); // Set the parsed date
                pstmt.setString(7, bloodGroup);
                pstmt.executeUpdate();
            }
            response.sendRedirect("registration.jsp");
        } catch (Exception e) {
            out.println("<p class='text-danger'>Error: " + e.getMessage() + "</p>");
        }
    } else {
        out.println("<p class='text-danger'>Invalid action specified.</p>");
    }
}
%>
   
  </div>
</body>
</html>