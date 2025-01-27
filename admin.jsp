<%@ include file="Adminheader.jsp" %>
<%@ include file="Adminslidebar.jsp" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container-fluid" style="margin-left: 200px;">
        <!-- Dashboard Header -->
        <div class="row mt-3">
            <h1 class="h3">Admin Dashboard</h1>
        </div>

        <!-- Fetch User Count -->
        <%
            int totalUsers = 0;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinevoting", "root", "root");
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT COUNT(*) AS total_users FROM voterusers");
                if (rs.next()) {
                    totalUsers = rs.getInt("total_users");
                }
                con.close();
            } catch (Exception e) {
                out.println("<p>Error fetching user count: " + e.getMessage() + "</p>");
            }
        %>

        <!-- Dashboard Stats -->
        <div class="row mt-4">
            <div class="col-md-4">
                <div class="card text-white bg-success">
                    <div class="card-body">
                        <h5 class="card-title">Total Registered Users</h5>
                        <p class="card-text"><%= totalUsers %></p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
