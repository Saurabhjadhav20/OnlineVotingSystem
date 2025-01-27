<%@ page language="java" import="java.sql.*" %>
<%@ page import="java.time.LocalDate, java.time.Period" %>
<!DOCTYPE html>
<html>
<head>
    <title>Age Confirmation</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            position: relative;
            margin: 0;
            padding: 0;
            height: 100vh;
        }

        #dashboardContent {
            position: absolute;
            width: 100%;
            height: 100%;
            z-index: 1;
        }

        #dashboardIframe {
            width: 100%;
            height: 100%;
            border: none;
            filter: blur(5px);
        }

        .modal-overlay {
            display: flex;
            justify-content: center;
            align-items: center;
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.7);
            z-index: 2;
        }

        .card {
            background-color: rgba(255, 255, 255, 0.8);
            border: none;
        }

        .hidden {
            display: none;
        }
    </style>
</head>
<body>
    <% 
        // Initialize variables
        boolean isAgeValid = false;
        String errorMessage = null;

        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String aadhar = request.getParameter("aadhar_number");

            try {
                // Database connection
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinevoting", "root", "root");

                // Query for date of birth using Aadhar
                PreparedStatement pstmt = con.prepareStatement("SELECT dob FROM voterusers WHERE aadhar_card = ?");
                pstmt.setString(1, aadhar);
                ResultSet rs = pstmt.executeQuery();

                if (rs.next()) {
                    // Retrieve date of birth
                    Date dob = rs.getDate("dob");
                    LocalDate birthDate = dob.toLocalDate();
                    LocalDate currentDate = LocalDate.now();

                    // Calculate age
                    int age = Period.between(birthDate, currentDate).getYears();
                    if (age >= 18) {
                        isAgeValid = true;
                        // Set age confirmation session
                        session.setAttribute("ageConfirmed", true);
                        response.sendRedirect("Dashbord.jsp");
                        return;
                    } else {
                        errorMessage = "You must be 18 or older to access the dashboard.";
                    }
                } else {
                    errorMessage = "Invalid Aadhar number. Please try again.";
                }

                // Close resources
                rs.close();
                pstmt.close();
                con.close();

            } catch (Exception e) {
                e.printStackTrace();
                errorMessage = "An error occurred while verifying your age. Please try again.";
            }
        }
    %>

    <!-- Dashboard content (iframe with blur) -->
    <div id="dashboardContent">
        <iframe id="dashboardIframe" src="Dashbord.jsp"></iframe>
    </div>

    <!-- Age Confirmation Modal -->
    <div id="ageConfirmationModal" class="modal-overlay <%= isAgeValid ? "hidden" : "" %>">
        <div class="card shadow p-4" style="width: 400px;">
            <h3 class="text-center mb-4">Age Confirmation</h3>
            <form method="post">
                <div class="mb-3">
                    <label for="aadhar" class="form-label">Enter Aadhar Number:</label>
                    <input type="text" id="aadhar" name="aadhar_number" class="form-control" required>
                </div>
                <button type="submit" class="btn btn-primary w-100">Submit</button>
            </form>
            <% if (errorMessage != null) { %>
                <div class="alert alert-danger mt-3">
                    <%= errorMessage %>
                </div>
            <% } %>
        </div>
    </div>

    <script>
        <% if (isAgeValid) { %>
            // Hide modal and remove blur when age is valid
            window.onload = function() {
                document.getElementById('dashboardIframe').style.filter = 'none';  // Remove blur from iframe
                document.getElementById('ageConfirmationModal').classList.add('hidden');
            };
        <% } %>
    </script>
</body>
</html>
