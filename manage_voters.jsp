<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="Adminheader.jsp" %>
<%@ include file="Adminslidebar.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Voters</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container-fluid" style="margin-left: 200px;">
        <!-- Header -->
        <div class="row mt-3">
            <h1 class="h3">Manage Voters</h1>
        </div>

        <!-- Add Voter Form -->
        <div class="row mt-4">
            <div class="col-md-6">
                <h4>Add Voter</h4>
                <form action="manage_voters.jsp" method="post">
                    <div class="mb-3">
                        <label for="full_name" class="form-label">Full Name</label>
                        <input type="text" name="full_name" id="full_name" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="father_name" class="form-label">Father Name</label>
                        <input type="text" name="father_name" id="father_name" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="mobile_number" class="form-label">Mobile Number</label>
                        <input type="text" name="mobile_number" id="mobile_number" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="aadhar_card" class="form-label">Aadhar Card</label>
                        <input type="text" name="aadhar_card" id="aadhar_card" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="pancard" class="form-label">PAN Card</label>
                        <input type="text" name="pancard" id="pancard" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="dob" class="form-label">Date of Birth</label>
                        <input type="date" name="dob" id="dob" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="blood_group" class="form-label">Blood Group</label>
                        <input type="text" name="blood_group" id="blood_group" class="form-control" required>
                    </div>
                    <button type="submit" name="action" value="add" class="btn btn-primary">Add Voter</button>
                </form>
            </div>
        </div>

        <!-- Display Voters -->
        <div class="row mt-5">
            <h4>Voter List</h4>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Full Name</th>
                        <th>Father Name</th>
                        <th>Mobile Number</th>
                        <th>Aadhar Card</th>
                        <th>PAN Card</th>
                        <th>DOB</th>
                        <th>Blood Group</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinevoting", "root", "root");

                            // Fetch all voters
                            Statement stmt = con.createStatement();
                            ResultSet rs = stmt.executeQuery("SELECT * FROM voterusers");

                            while (rs.next()) {
                                int id = rs.getInt("id");
                                String fullName = rs.getString("full_name");
                                String fatherName = rs.getString("father_name");
                                String mobileNumber = rs.getString("mobile_number");
                                String aadharCard = rs.getString("aadhar_card");
                                String pancard = rs.getString("pancard");
                                Date dob = rs.getDate("dob");
                                String bloodGroup = rs.getString("blood_group");
                    %>
                    <tr>
                        <td><%= id %></td>
                        <td><%= fullName %></td>
                        <td><%= fatherName %></td>
                        <td><%= mobileNumber %></td>
                        <td><%= aadharCard %></td>
                        <td><%= pancard %></td>
                        <td><%= dob %></td>
                        <td><%= bloodGroup %></td>
                        <td>
                            <form action="manage_voter.jsp" method="post" style="display: inline;">
                                <input type="hidden" name="id" value="<%= id %>">
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

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinevoting", "root", "root");

                    if ("add".equalsIgnoreCase(action)) {
                        // Add Voter
                        String fullName = request.getParameter("full_name");
                        String fatherName = request.getParameter("father_name");
                        String mobileNumber = request.getParameter("mobile_number");
                        String aadharCard = request.getParameter("aadhar_card");
                        String pancard = request.getParameter("pancard");
                        String dob = request.getParameter("dob");
                        String bloodGroup = request.getParameter("blood_group");

                        PreparedStatement pstmt = con.prepareStatement("INSERT INTO voterusers (full_name, father_name, mobile_number, aadhar_card, pancard, dob, blood_group) VALUES (?, ?, ?, ?, ?, ?, ?)");
                        pstmt.setString(1, fullName);
                        pstmt.setString(2, fatherName);
                        pstmt.setString(3, mobileNumber);
                        pstmt.setString(4, aadharCard);
                        pstmt.setString(5, pancard);
                        pstmt.setString(6, dob);
                        pstmt.setString(7, bloodGroup);
                        pstmt.executeUpdate();
                        response.sendRedirect("manage_voters.jsp");
                    } else if ("delete".equalsIgnoreCase(action)) {
                        // Delete Voter
                        int id = Integer.parseInt(request.getParameter("id"));

                        PreparedStatement pstmt = con.prepareStatement("DELETE FROM voterusers WHERE id = ?");
                        pstmt.setInt(1, id);
                        pstmt.executeUpdate();
                        response.sendRedirect("manage_voters.jsp");
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
