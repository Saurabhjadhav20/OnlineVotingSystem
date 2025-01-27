<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="navbar.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Voting Results</title>
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
        .container {
            position: relative;
        }
        .statistics, .leader {
            font-size: 18px;
        }
        .leader {
            text-align: left; /* Align to the left */
        }
        .statistics {
            text-align: right; /* Align to the right */
        }
        .card-custom {
            background-color: #6c757d; /* Gray background */
            color: white; /* White text */
            padding: 20px;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center">Voting Results</h1>

        <div class="row">
            <%
                // Initialize variables
                int totalVotes = 0;
                int totalCandidates = 0;
                String leadCandidateName = "";
                int leadCandidateVotes = 0;

                Connection connection = null;
                Statement statement = null;
                ResultSet resultSet = null;

                try {
                    // Load JDBC Driver and connect to the database
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinevoting", "root", "root");
                    statement = connection.createStatement();

                    // Fetch candidates and their votes
                    resultSet = statement.executeQuery("SELECT * FROM candidates");

                    while (resultSet.next()) {
                        String candidateId = resultSet.getString("candidate_id");
                        String name = resultSet.getString("name");
                        String party = resultSet.getString("party");
                        String education = resultSet.getString("education");
                        String image = resultSet.getString("image_url");
                        int votes = resultSet.getInt("votes");

                        totalVotes += votes;  // Accumulate total votes
                        totalCandidates++;  // Count total candidates

                        // Check if this candidate has the most votes
                        if (votes > leadCandidateVotes) {
                            leadCandidateVotes = votes;
                            leadCandidateName = name;
                        }
            %>

            <div class="col-md-4 mb-4">
                <div class="card" style="border: 1px solid black; background-color: rgba(0, 0, 0, 0.0);">
                    <img src="<%= image %>" class="card-img-top" alt="<%= name %>">
                    <div class="card-body" style="color: white;">
                        <h5 class="card-title"><%= name %></h5>
                        <p class="card-text"><strong>Party:</strong> <%= party %></p>
                        <p class="card-text"><strong>Education:</strong> <%= education %></p>
                        <p class="card-text"><strong>Votes:</strong> <%= votes %></p>
                    </div>
                </div>
            </div>

            <%
                    }
                    
                    // Set the request attributes after calculations
                    request.setAttribute("totalVotes", totalVotes);
                    request.setAttribute("totalCandidates", totalCandidates);
                    request.setAttribute("leadCandidateName", leadCandidateName);
                    request.setAttribute("leadCandidateVotes", leadCandidateVotes);

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

        <!-- Statistics and Lead Candidate Section -->
        <div class="row mt-5">
            <!-- Statistics Section (Right) -->
            <div class="col-md-6">
                <div class="card-custom">
                    <h4>Statistics</h4>
                    <p><strong>Total Votes:</strong> <%= request.getAttribute("totalVotes") %></p>
                    <p><strong>Number of Candidates:</strong> <%= request.getAttribute("totalCandidates") %></p>
                </div>
            </div>

            <!-- Lead Candidate Section (Left) -->
            <div class="col-md-6">
                <div class="card-custom">
                    <h4>Lead Candidate</h4>
                    <p><strong>Name:</strong> <%= request.getAttribute("leadCandidateName") %></p>
                    <p><strong>Votes:</strong> <%= request.getAttribute("leadCandidateVotes") %></p>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
