<%@ include file="navbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Home Page</title>
    <!-- Include Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body, html {
            height: 100%;
            margin: 0;
            background: url('background.jpg') no-repeat center center fixed; /* Replace 'background.jpg' with your image file */
            background-size: cover;
            color: white;
        }
        .header {
            background-color: rgba(0, 0, 0, 0.7); /* Semi-transparent background */
            padding: 20px 0;
        }
        .header h1 {
            margin: 0;
            font-size: 2.5rem;
            text-align: center;
        }
        .cards-container {
            height: calc(100% - 80px); /* Adjust height to accommodate header */
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .card {
            width: 300px;
            height: 180px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            text-align: center;
            border-radius: 15px;
            margin: 15px;
            padding: 20px;
        }
        .card h4 {
            margin: 10px 0 5px;
            font-size: 1.5rem;
        }
        .card p {
            margin: 5px 0 0;
            font-size: 1rem;
        }
        .card-icon {
            font-size: 3rem;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <div class="header">
        <h1>Welcome to Online Voting</h1>
    </div>

    <!-- Cards Section -->
    <div class="cards-container">
        <div class="row g-4 justify-content-center">
            <!-- Registration Card -->
            <div class="col-auto">
                <a href="registration.jsp" style="text-decoration: none;">
                    <div class="card bg-primary">
                        <i class="bi bi-person-plus card-icon"></i>
                        <h4>Registration</h4>
                        <p>Create your account to participate in elections.</p>
                    </div>
                </a>
            </div>
            <!-- Admin Dashboard Card -->
            <div class="col-auto">
                <a href="admin.jsp" style="text-decoration: none;">
                    <div class="card bg-success">
                        <i class="bi bi-speedometer2 card-icon"></i>
                        <h4>Admin Dashboard</h4>
                        <p>Manage users, elections, and results.</p>
                    </div>
                </a>
            </div>
            <!-- Voter Dashboard Card -->
            <div class="col-auto">
                <a href="ageConfirmation.jsp" style="text-decoration: none;">
                    <div class="card bg-danger">
                        <i class="bi bi-person-badge card-icon"></i>
                        <h4>Voter Dashboard</h4>
                        <p>View elections and cast your votes securely.</p>
                    </div>
                </a>
            </div>
            <!-- Vote Page Card -->
            <div class="col-auto">
                <a href="ageConfirmation.jsp" style="text-decoration: none;">
                    <div class="card bg-warning">
                        <i class="bi bi-box-seam card-icon"></i>
                        <h4>Vote Page</h4>
                        <p>Vote for your preferred candidates in elections.</p>
                    </div>
                </a>
            </div>
            <!-- Result Page Card -->
            <div class="col-auto">
                <a href="result.jsp" style="text-decoration: none;">
                    <div class="card bg-info">
                        <i class="bi bi-bar-chart-line card-icon"></i>
                        <h4>Result Page</h4>
                        <p>View election results and statistics.</p>
                    </div>
                </a>
            </div>
            <!-- Services Card -->
            <div class="col-auto">
                <a href="services.jsp" style="text-decoration: none;">
                    <div class="card bg-secondary">
                        <i class="bi bi-gear card-icon"></i>
                        <h4>Services</h4>
                        <p>Explore additional features and services.</p>
                    </div>
                </a>
            </div>
        </div>
    </div>

    <!-- Include Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
