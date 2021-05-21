<%@page import="db.InitDB"%>
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
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/style.css" />
<link rel="icon" href="images/favicon.png" />
<script src='js/location.js'></script>

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
				<li class="nav-item active"><a class="nav-link"
					href="dashboard.jsp">Dashboard <span class="sr-only">(current)</span>
				</a></li>
				<li class="nav-item active"><a class="nav-link"
					href="rentmyspace.jsp">Rent my space</a></li>
				<li class="nav-item active"><a class="nav-link"
					href="parkmyvehicle.jsp">Park my vehicle</a></li>



			</ul>
			<%
			session = request.getSession();
			String email = (String) session.getAttribute("email");
			%>
			<ul class="navbar-nav ml-auto">
				<li class="nav-item active login-text"><a class="nav-link"
					href="<%if (email == null)
	out.println("login.jsp");%>"> <%
 out.println(email);
 %>
				</a></li>
			</ul>
		</div>
	</nav>

	<!--  Search bar -->
	<div class='container border-bottom pt-5' style='padding: 10px;'>
		<form action='parkmyvehicle.jsp' method='GET'>
			<div class='form-row'>
				<div class='form-group col-md-4'>
					<input type='text' placeholder='411043' class='form-control'
						id='inputPincode' name='inputPincode' required>
				</div>
				<div class='form-group col-md-6'>
					<input type='text' placeholder='Pune' class='form-control'
						id='inputCity' name='inputCity' required>
				</div>

				<input type='hidden' class='form-control' name='lat' id='lat'>
				<input type='hidden' class='form-control' name='lng' id='lng'>

				<div class='form-group col-md-2'>
					<button type='submit' class='btn btn-primary btn-block'>Search</button>
				</div>
			</div>
		</form>
	</div>

	<div class='container align-items-center'>
		<div class='row'>
			<%
			String pincode = request.getParameter("inputPincode");
			String city = request.getParameter("inputCity");
			String lat = request.getParameter("lat");
			String lng = request.getParameter("lng");
			
			if(pincode == null)
				return;
			
			else {
				Connection con = (Connection) InitDB.getConnection();
				List<String> cityId = new ArrayList<String>();
				PreparedStatement statement;
				try {
					if (lat != "" && lng != "") {
						statement = con.prepareStatement(
								"SELECT cityId, (6371 *  acos(cos(radians(?)) * cos(radians(lat)) * cos(radians(lng) -  radians(?)) + sin(radians(?)) *  sin(radians(lat ))) ) AS distance FROM city HAVING distance < 45 ORDER BY distance LIMIT 0, 20");

						statement.setString(1, lat);
						statement.setString(2, lng);
						statement.setString(3, lat);
					} else {
						statement = con
								.prepareStatement("SELECT cityId FROM city WHERE city LIKE '%'?'%' OR pincode = ?");

						statement.setString(1, city);
						statement.setString(2, pincode);
					}

					ResultSet rs = statement.executeQuery();
					while (rs.next()) {
						cityId.add(rs.getString("cityId"));
					}

					if (cityId.size() > 0) {
						String sql = "SELECT * FROM parking WHERE cityId =";

						for (int i = 0; i < cityId.size() - 1; i++) {
							sql = sql + cityId.get(i) + " OR cityId = ";
						}
						sql = sql + cityId.get(cityId.size() - 1);

						statement = con.prepareStatement(sql);
						rs = statement.executeQuery();
						
						while (rs.next()) { 
							out.println("<div class='card h-100' style='width: 20rem; margin: 10px;'><img src=");
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
						rs.close();
						
					} else {
						out.println("<p text-primary> No Records Found </p>");
					}

				} catch (SQLException e) {
					e.printStackTrace();
				} finally {
					InitDB.closeConnection();
				}
			}
			%>
		</div>
	</div>


	<script type="text/javascript" src="js/dashboard.js"></script>
	<!-- Optional JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script src='https://code.jquery.com/jquery-3.4.1.slim.min.js'
		integrity='sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n'
		crossorigin='anonymous'></script>
	<script
		src='https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js'
		integrity='sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo'
		crossorigin='anonymous'></script>
	<script
		src='https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js'
		integrity='sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6'
		crossorigin='anonymous'></script>

</body>
</html>