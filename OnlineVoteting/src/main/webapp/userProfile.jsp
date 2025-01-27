<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .profile-container {
            width: 50%;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ddd;
            background-color: #f9f9f9;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table th, table td {
            padding: 8px;
            text-align: left;
        }
        table th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <div class="profile-container">
        <h1>User Profile</h1>
        <%
            // Database connection details
            String url = "jdbc:mysql://localhost:3306/your_database";
            String username = "root";
            String password = "password";

            
            HttpSession session = request.getSession();
            Integer userId = (Integer) session.getAttribute("userId");
            if (userId == null) {
                out.println("User not logged in");
                return;
            }

            // Fetch user details from the database
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection connection = DriverManager.getConnection(url, username, password);
                String query = "SELECT * FROM voterusers WHERE id = ?";
                PreparedStatement statement = connection.prepareStatement(query);
                statement.setInt(1, userId);
                ResultSet resultSet = statement.executeQuery();

                if (resultSet.next()) {
        %>
                    <table>
                        <tr>
                            <th>Full Name</th>
                            <td><%= resultSet.getString("full_name") %></td>
                        </tr>
                        <tr>
                            <th>Father's Name</th>
                            <td><%= resultSet.getString("father_name") %></td>
                        </tr>
                        <tr>
                            <th>Mobile Number</th>
                            <td><%= resultSet.getString("mobile_number") %></td>
                        </tr>
                        <tr>
                            <th>Aadhar Card</th>
                            <td><%= resultSet.getString("aadhar_card") %></td>
                        </tr>
                        <tr>
                            <th>PAN Card</th>
                            <td><%= resultSet.getString("pancard") %></td>
                        </tr>
                        <tr>
                            <th>Date of Birth</th>
                            <td><%= resultSet.getDate("dob") %></td>
                        </tr>
                        <tr>
                            <th>Blood Group</th>
                            <td><%= resultSet.getString("blood_group") %></td>
                        </tr>
                    </table>
        <%
                } else {
                    out.println("User not found");
                }

                resultSet.close();
                statement.close();
                connection.close();
            } catch (Exception e) {
                e.printStackTrace();
                out.println("Error fetching user data");
            }
        %>
    </div>
</body>
</html>
