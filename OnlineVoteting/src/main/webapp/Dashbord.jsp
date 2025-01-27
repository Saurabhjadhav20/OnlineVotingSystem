<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="navbar.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Voter Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-image: url('dashbordbackground.jpg');
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
            color: #fff;
        }
        .card {
            background-color: rgba(255, 255, 255, 0.8);
            border: none;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center">Voter Dashboard</h1>
        <h3 class="text-center">Select Your Candidate</h3>
        
        <form method="post">
            <div class="row">
                <%
                    Connection connection = null;
                    Statement statement = null;
                    ResultSet resultSet = null;
                    String successMessage = null;

                    if (request.getMethod().equalsIgnoreCase("POST")) {
                        String candidateId = request.getParameter("candidateId");

                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinevoting", "root", "root");

                            
                            String updateQuery = "UPDATE candidates SET votes = votes + 1 WHERE candidate_id = ?";
                            PreparedStatement stmt = connection.prepareStatement(updateQuery);
                            stmt.setString(1, candidateId);
                            int rowsUpdated = stmt.executeUpdate();
                            if (rowsUpdated > 0) {
                                successMessage = "Your vote has been successfully submitted!";
                            }

                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            try {
                                if (resultSet != null) resultSet.close();
                                if (statement != null) statement.close();
                                if (connection != null) connection.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                    }

                    
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinevoting", "root", "root");
                        statement = connection.createStatement();
                        resultSet = statement.executeQuery("SELECT * FROM candidates");

                        while (resultSet.next()) {
                            String candidateId = resultSet.getString("candidate_id");
                            String name = resultSet.getString("name");
                            String party = resultSet.getString("party");
                            String education = resultSet.getString("education");
                            String image = resultSet.getString("image_url");
                %>
                
                <div class="col-md-4 mb-4">
                    <div class="card" style="border: 1px solid black; background-color: rgba(0, 0, 0, 0.0);">
                        <img src="<%= image %>" class="card-img-top" alt="<%= name %>">
                        <div class="card-body" style="color: white;">
                            <h5 class="card-title"><%= name %></h5>
                            <p class="card-text colour"><strong>Party:</strong> <%= party %></p>
                            <p class="card-text"><strong>Education:</strong> <%= education %></p>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="candidateId" value="<%= candidateId %>" required>
                                <label class="form-check-label">Vote for <%= name %></label>
                            </div>
                        </div>
                    </div>
                </div>

                <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        try {
                            if (resultSet != null) resultSet.close();
                            if (statement != null) statement.close();
                            if (connection != null) connection.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                %>
            </div>
            <div class="text-center">
                <button type="submit" class="btn btn-primary">Submit Your Vote</button>
            </div>
        </form>

        <% if (successMessage != null) { %>
            <div class="alert alert-success mt-3 text-center">
                <%= successMessage %>
            </div>
        <% } %>

    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
