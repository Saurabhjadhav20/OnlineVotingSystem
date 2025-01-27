<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Page</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="d-flex justify-content-center align-items-center vh-100">

<div class="card shadow p-4" style="width: 400px;">
    <h3 class="text-center mb-4">Login</h3>
    <form action="homepage.jsp" method="post">
        <div class="mb-3">
            <label for="username" class="form-label">Username</label>
            <input type="text" name="username" id="username" class="form-control" required>
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" name="password" id="password" class="form-control" required>
        </div>
        <button type="submit" class="btn btn-primary w-100">Login</button>
        <a href="LoginRegistration.jsp" class="text-center">New User?Signup Here!!!</a>
    </form>
    <div class="mt-3 text-center">
        <%
        try{
              Class.forName("com.mysql.cj.jdbc.Driver");
              Connection con= DriverManager.getConnection("jdbc:mysql://localhost:3006/onlinevoting","root","root");
              PreparedStatement pstmt = con.prepareStatement("select * from users where(?,?)");
                    		String un= request.getParameter("username");
                    		String ps=request.getParameter("password");
                    		pstmt.setString(1, un);
                    		pstmt.setString(2, ps);
                    	   // pstmt.executeUpdate();
                    	    ResultSet rs = pstmt.executeQuery();
                    	    if(rs.next()){
                    	    RequestDispatcher rd= request.getRequestDispatcher("homepage.jsp");
                            rd.forward(request, response);
                    	    }else{
                    	    	 out.println("<p class='text-danger text-center'>Invalid username or password!</p>");
                    	    }
        }catch(Exception e){
        	
        }
                    		
        %>
    </div>
</div>

</body>
</html>
