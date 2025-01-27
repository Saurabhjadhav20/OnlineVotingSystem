<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <h2 class="mb-4 text-center">Register</h2>
                <form action="index.html" method="post">
                    <div class="mb-3">
                        <label for="name" class="form-label">Full Name</label>
                        <input type="text" name="name" id="name" class="form-control" placeholder="Enter your full name" required>
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" name="email" id="email" class="form-control" placeholder="Enter your email" required>
                    </div>
                    <div class="mb-3">
                        <label for="mobno" class="form-label">Mobile Number</label>
                        <input type="text" name="mobno" id="mobno" class="form-control" placeholder="Enter your mobile number" required>
                    </div>
                    <div class="mb-3">
                        <label for="username" class="form-label">Username</label>
                        <input type="text" name="username" id="username" class="form-control" placeholder="Choose a username" required>
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">Password</label>
                        <input type="password" name="password" id="password" class="form-control" placeholder="Create a password" required>
                    </div>
                    <button type="submit" class="btn btn-success w-100">Register</button>
                </form>
            </div>
        </div>
    </div>

    <%-- JSP Code for Database Integration --%>
    <% 
        if (request.getMethod().equalsIgnoreCase("post")) {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String mobno = request.getParameter("mobno");
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/your_database_name", "root", "your_password");
                String query = "INSERT INTO users (name, email, mobno, username, password) VALUES (?, ?, ?, ?, ?)";
                PreparedStatement pstmt = con.prepareStatement(query);
                pstmt.setString(1, name);
                pstmt.setString(2, email);
                pstmt.setString(3, mobno);
                pstmt.setString(4, username);
                pstmt.setString(5, password);
                pstmt.executeUpdate();
                con.close();
                out.println("<div class='alert alert-success text-center'>Registration Successful!</div>");
            } catch (Exception e) {
                out.println("<div class='alert alert-danger text-center'>Error: " + e.getMessage() + "</div>");
            }
        }
    %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
