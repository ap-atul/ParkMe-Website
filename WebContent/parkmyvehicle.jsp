<%@ page language='java' contentType='text/html; charset=ISO-8859-1'
	pageEncoding='ISO-8859-1'%>
<%@ page import='java.sql.*'%>
<%@ page import='java.io.*'%>
<%@ page import='java.util.*'%>
<!doctype html>
<html lang='en'>
<head>
<!-- Required meta tags -->
<meta charset='utf-8'>
<meta name='viewport'
	content='width=device-width, initial-scale=1, shrink-to-fit=no'>

<!-- Bootstrap CSS -->
<link rel='stylesheet' href='css/bootstrap.min.css'>
<link rel='stylesheet' href='css/style.css' />
<script src='js/location.js'></script>
<link rel='icon' href='images/favicon.png' />

<title>Welcome to Park Me</title>
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
				<li class="nav-item "><a class="nav-link"
					href="dashboard.jsp">Dashboard <span class="sr-only">(current)</span>
				</a></li>
				<li class="nav-item "><a class="nav-link"
					href="rentmyspace.jsp">Rent my space</a></li>
				<li class="nav-item active"><a class="nav-link"
					href="parkmyvehicle.jsp">Park my vehicle</a></li>



			</ul>
			<%
				session = request.getSession();
				String email = (String) session.getAttribute("email");
			%>
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

	<!--  Search bar -->
	<div class='container border-bottom pt-5' style='padding: 10px;'>
		<form action='Search' method='POST'>
			<div class='form-row'>
				<div class='form-group col-md-4'>
					<input type='text' placeholder='Pincode' class='form-control'
						id='inputPincode' name='inputPincode' required>
				</div>
				<div class='form-group col-md-6'>
					<input type='text' placeholder='City Name' class='form-control'
						id='inputCity' name='inputCity' required>
				</div>

				<div class='form-group col-md-2'>
					<button type='submit' class='btn btn-primary btn-block'>Search</button>
				</div>
			</div>
		</form>
	</div>

	<div class='container align-items-center'>
		<div class='row'>
			<%
				if (application.getAttribute("city") != null) {
					String city = (String) application.getAttribute("city");
					String pincode = (String) application.getAttribute("pincode");
					
					Class.forName("com.mysql.cj.jdbc.Driver");
					Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/parkme?useSSL=false", "root",
							"root");
					
					String sql = "SELECT DISTINCT p.parkingId, p.placeName, p.ownerName, p.userId, p.cityId,"
							+ " p.spots, p.fare, p.contact, p.image FROM"
							+ " parking AS p INNER JOIN city AS c ON  p.cityId ="
							+ " (SELECT cityId FROM city WHERE city LIKE '%" + city + "%' AND pincode = " + pincode + " LIMIT 1)";
					PreparedStatement statement = con.prepareStatement(sql);

					ResultSet rs = statement.executeQuery();
					

					while (rs.next()) {
						out.println("<div class='shadow card h-100' style='width: 20rem; margin: 10px;'><img src=");
						out.println("'GetImage?parkingId=" + rs.getString("parkingId") + "'"
								+ " class='card-img-top' style='height : 212px;' alt='...'><div class='card-body'><h5 class='card-title'> ");
						out.println(rs.getString("placeName") + "</h5>");
						out.println("<p class='text-primary'>Owner Name :- " + rs.getString("ownerName"));
						out.println("<br>Number of Spots :- " + rs.getString("spots"));
						out.println("<br>Fare :- " + rs.getString("fare") + "Rs");
						out.println("<br>Contact :- " + rs.getString("contact") + "</p>");
						out.println("<a href='SelectCar?parkingId=" + rs.getString("parkingId")
								+ "' class='btn btn-primary'>Book</a></div></div>");
					}
				} else {
					out.println("<p text-primary> No Records Found </p>");
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