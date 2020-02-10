<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import='java.sql.*'%>
<%@ page import='java.io.*'%>
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
						<li><a href="#">Profile</a></li>
						<li><a href="#">Logout</a></li>
					</ul>
			</ul>
		</div>
	</nav>

	<!--Dash Board Contents  -->
	<nav class="navbar" style="margin-top: auto; padding: 10px;">
		<ul class="nav nav-tabs">
			<li class="nav-item"><a class="nav-link" href="dashboard.jsp">My
					Cars</a></li>
			<li class="nav-item"><a class="nav-link" href="myparking.jsp">My
					Parking</a></li>
			<li class="nav-item"><a class="nav-link "
				href="currentparking.jsp">Current Parking</a></li>
			<li class="nav-item"><a class="nav-link active"
				href="parkinghistory.jsp">Parking History</a></li>
		</ul>
	</nav>


	<p class="badge badge-primary" style="margin: 10px;">Your Car
		Parking History</p>

	<div class='container align-items-center' style="">
		<div class='row'>
			<%
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/parkme?useSSL=false","root","root");
			Cookie[] cookies = request.getCookies();
			Cookie cookie = null;
			String userId = null;
			PreparedStatement statement = null;
			ResultSet rs = null;
			
			if( cookies != null ) {
				for (int i = 0; i < cookies.length; i++) {
					cookie = cookies[i];
					if(cookie.getName().equals("userId")) {
						userId = cookie.getValue();
					}
				}
			} 
			try {
				if(userId != null) {
					statement = con.prepareStatement("SELECT * from booking where userId = ? AND completion = 1");
					statement.setString(1, userId);


					rs = statement.executeQuery();
					while (rs.next()) {
						out.println(
								"<div class='shadow card h-100' style='width: 20rem; margin: 10px;'><img src=");
						out.println("'GetCarImage?carId=" + rs.getString("carId") + "'" + " class='card-img-top' style='height : 212px;' alt='...'><div class='card-body'>");
						out.println("<p class='text-primary'>Amount Paid :- " + rs.getString("price"));
						out.println("<br> Date of parking :-" + rs.getString("datePlaced"));
						out.println("<br> Time of parking :-" + rs.getString("timePlaced"));
						out.println("<br> Hour(s) parked :-" + rs.getString("hour"));
						out.println("</p></div></div>");
						
					}
				}
				
			}catch (SQLException e) {
				e.printStackTrace();
			}
			%>
		</div>
	</div>

	<p class="badge badge-primary" style="margin: 10px;">Your Space
		History</p>
	<div class='container align-items-center' style="">
		<div class='row'>
			<%
			
			if( cookies != null ) {
				for (int i = 0; i < cookies.length; i++) {
					cookie = cookies[i];
					if(cookie.getName().equals("userId")) {
						userId = cookie.getValue();
					}
				}
			} 
			try {
				if(userId != null) {
					statement = con.prepareStatement("SELECT * from parking where userId = ?");
					statement.setString(1, userId);


					rs = statement.executeQuery();
					while (rs.next()) {
						out.println(
								"<div class='shadow card h-100' style='width: 20rem; margin: 10px;'><img src=");
						out.println("'GetImage?parkingId=" + rs.getString("parkingId") + "'" + " class='card-img-top' style='height : 212px;' alt='...'><div class='card-body'><h5 class='card-title'> ");
						out.println(rs.getString("placeName") + "</h5>");
						out.println("<p class='text-primary'>Owner Name :- " + rs.getString("ownerName"));
						out.println("<br>Number of Spots :- " + rs.getString("spots"));
						out.println("<br>Fare :- " + rs.getString("fare")+ "Rs");
						out.println("<br>Contact :- " + rs.getString("contact")+ "</p>");
						out.println("<a href='oldparkedcars.jsp?parkingId="+ rs.getString("parkingId") +"' class='btn btn-primary'>View Details</a></div></div>");
						
					}
				}
				
			}catch (SQLException e) {
				e.printStackTrace();
			}finally{
				con.close();
			}
			%>
		</div>
	</div>


	<script type="text/javascript" src="js/dashboard.js"></script>
	<!-- Optional JavaScript -->
	<script type="text/javascript" src="js/jquery.js"></script>
	<script type="text/javascript" src="js/popper.js"></script>
	<script type="text/javascript" src="js/bootstrap.min.js"></script>
</body>
</html>