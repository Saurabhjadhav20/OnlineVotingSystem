<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="Adminheader.jsp" %>
<%@ include file="Adminslidebar.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Candidates</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container-fluid" style="margin-left: 200px;">
        <!-- Header -->
        <div class="row mt-3">
            <h1 class="h3">Manage Candidates</h1>
        </div>

        <!-- Add Candidate Form -->
        <div class="row mt-4">
            <div class="col-md-6">
                <h4>Add Candidate</h4>
                <form action="manage_candidates.jsp" method="post">
                    <div class="mb-3">
                        <label for="candidate_id" class="form-label">Candidate ID</label>
                        <input type="text" name="candidate_id" id="candidate_id" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="name" class="form-label">Name</label>
                        <input type="text" name="name" id="name" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="party" class="form-label">Party</label>
                        <input type="text" name="party" id="party" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="education" class="form-label">Education</label>
                        <input type="text" name="education" id="education" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="image_url" class="form-label">Image URL</label>
                        <input type="text" name="image_url" id="image_url" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="votes" class="form-label">Votes</label>
                        <input type="number" name="votes" id="votes" class="form-control" value="0" required>
                    </div>
                    <button type="submit" name="action" value="add" class="btn btn-primary">Add Candidate</button>
                </form>
            </div>
        </div>

        <!-- Display Candidates -->
        <div class="row mt-5">
            <h4>Candidate List</h4>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Candidate ID</th>
                        <th>Name</th>
                        <th>Party</th>
                        <th>Education</th>
                        <th>Image</th>
                        <th>Votes</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinevoting", "root", "root");

                            // Fetch all candidates
                            Statement stmt = con.createStatement();
                            ResultSet rs = stmt.executeQuery("SELECT * FROM candidates");

                            while (rs.next()) {
                                String candidateId = rs.getString("candidate_id");
                                String name = rs.getString("name");
                                String party = rs.getString("party");
                                String education = rs.getString("education");
                                String imageUrl = rs.getString("image_url");
                                int votes = rs.getInt("votes");
                    %>
                    <tr>
                        <td><%= candidateId %></td>
                        <td><%= name %></td>
                        <td><%= party %></td>
                        <td><%= education %></td>
                        <td><img src="<%= imageUrl %>" alt="Candidate Image" style="width: 50px; height: 50px;"></td>
                        <td><%= votes %></td>
                        <td>
                            <form action="manage_candidates.jsp" method="post" style="display: inline;">
                                <input type="hidden" name="candidate_id" value="<%= candidateId %>">
                                <button type="submit" name="action" value="delete" class="btn btn-danger btn-sm">Delete</button>
                            </form>
                        </td>
                    </tr>
                    <%
                            }
                            con.close();
                        } catch (Exception e) {
                            out.println("<p class='text-danger'>Error: " + e.getMessage() + "</p>");
                        }
                    %>
                </tbody>
            </table>
        </div>

        <!-- Handle Add and Delete Actions -->
        <%
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String action = request.getParameter("action");
                String candidateId = request.getParameter("candidate_id");

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinevoting", "root", "root");

                    if ("add".equalsIgnoreCase(action)) {
                        // Add Candidate
                        String name = request.getParameter("name");
                        String party = request.getParameter("party");
                        String education = request.getParameter("education");
                        String imageUrl = request.getParameter("image_url");
                        int votes = Integer.parseInt(request.getParameter("votes"));

                        PreparedStatement pstmt = con.prepareStatement("INSERT INTO candidates VALUES (?, ?, ?, ?, ?, ?)");
                        pstmt.setString(1, candidateId);
                        pstmt.setString(2, name);
                        pstmt.setString(3, party);
                        pstmt.setString(4, education);
                        pstmt.setString(5, imageUrl);
                        pstmt.setInt(6, votes);
                        pstmt.executeUpdate();
                        response.sendRedirect("manage_candidates.jsp");
                    } else if ("delete".equalsIgnoreCase(action)) {
                        // Delete Candidate
                        PreparedStatement pstmt = con.prepareStatement("DELETE FROM candidates WHERE candidate_id = ?");
                        pstmt.setString(1, candidateId);
                        pstmt.executeUpdate();
                        response.sendRedirect("manage_candidates.jsp");
                    }
                    con.close();
                } catch (Exception e) {
                    out.println("<p class='text-danger'>Error: " + e.getMessage() + "</p>");
                }
            }
        %>
    </div>
</body>
</html>
