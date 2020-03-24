<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import='java.sql.*'%>
<%@ page import='java.io.*'%>
<%@ page import='db.*'%>
<%@ page import='java.util.*'%>
<!doctype html>
<html lang="en">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel='stylesheet' href='css/bootstrap.min.css'>
<link rel="stylesheet" href="css/style.css" />
<link rel='icon' href='images/favicon.png' />

<title>DashBoard</title>
</head>
<body>

	<!-- 	Navigation Bar -->
	<nav class="navbar navbar-expand-md navbar-dark bg-primary">
		<a class="navbar-brand" href="index.jsp">Park Me</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#collapsingNavbar">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="navbar-collapse collapse" id="collapsingNavbar">
			<ul class="navbar-nav">
				<li class="nav-item active"><a class="nav-link"
					href="dashboard.jsp">Dashboard <span class="sr-only">(current)</span>
				</a></li>
				<li class="nav-item active"><a class="nav-link"
					href="rentmyspace.jsp">Rent my space</a></li>
				<li class="nav-item active"><a class="nav-link"
					href="parkmyvehicle.jsp">Park my vehicle</a></li>



			</ul>
			<%session = request.getSession();
			String email = (String)session.getAttribute("email");%>
			<ul class="navbar-nav ml-auto">
				<li class="dropdown"><a class="text-light dropdown-toggle"
					data-toggle="dropdown" href="<%if (email == null)
				out.println("login.jsp");%>"><%
							out.println(email);
						%><span class="caret"></span></a>
					<ul class="dropdown-menu text-center">
						<li><a href="profile.jsp">Profile</a></li>
						<li><a href="Logout">Logout</a></li>
					</ul>
			</ul>
		</div>
	</nav>

	<!--Dash Board Contents  -->
	<nav class="navbar" style="margin-top: auto; padding: 10px;">
		<ul class="nav nav-tabs">
			<li class="nav-item"><a class="nav-link "
				href="dashboard.jsp">My Cars</a></li>
			<li class="nav-item"><a class="nav-link" href="myparking.jsp">My
					Parking</a></li>
			<li class="nav-item"><a class="nav-link"
				href="currentparking.jsp">Current Parking</a></li>
			<li class="nav-item"><a class="nav-link"
				href="parkinghistory.jsp">Parking History</a></li>
			<li class="nav-item"><a class="nav-link active"
				href="profile.jsp">My Profile</a></li>
		</ul>
	</nav>

<% 
			String userId = request.getParameter("userId");
			if(userId == null)
				userId = request.getSession().getAttribute("userId").toString();
						
			PreparedStatement ps = InitDB.getConnection().prepareStatement("SELECT * FROM user WHERE userId = ?");
			ps.setString(1, userId);
			
			ResultSet rs = ps.executeQuery();
			String name = "", image="", city="", contact="";
			while(rs.next()){
				name = rs.getString("name");
				image = rs.getString("image");
				city = rs.getString("city");
				contact = rs.getString("contact");
			}
			%>
			
	<div class="card w-50">
		<div class="row m-5 p-5">
				<div class="col-sm">
					<img src="<%= image %>" style="width: 150px;">
				</div>
				
				<div class="col">
					<h2><%= name %></h2>
					<h3><%= email %></h3>
					<h3><%= city %></h3>
					<h3><%= contact %></h3>
				</div>
				
		</div>
	</div>
	
	
<script type="text/javascript" src="js/dashboard.js"></script>
	<!-- Optional JavaScript -->
	<script type="text/javascript" src="js/jquery.js"></script>
	<script type="text/javascript" src="js/popper.js"></script>
	<script type="text/javascript" src="js/bootstrap.min.js"></script>
</body>
</html>


