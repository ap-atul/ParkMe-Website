<%@page import="java.time.LocalDateTime"%>
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
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<link rel="stylesheet" href="css/style.css" />
<link rel='icon'
	href='https://upload.wikimedia.org/wikipedia/commons/thumb/5/52/Hong_Kong_road_sign_%28Parking%29.svg/768px-Hong_Kong_road_sign_%28Parking%29.svg.png' />

<title>DashBoard</title>
</head>
<body>
<a class="badge badge-primary" href="dashboard.jsp"
		style="margin: 10px;">Go to DashBoard</a>
	<p class="badge badge-primary"
		style="margin: 10px;">All Parked Cars</p>

	<div class='container align-items-center' style="">
		<div class='row'>


	<%
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/parkme?useSSL=false", "root",
				"root");
		
		String parkingId = request.getParameter("parkingId");
		
		PreparedStatement statement = null;
		ResultSet rs = null;
		
		LocalDateTime dateTime = null;
		String dateT = null, time[] = null;
		
		try {
			if (parkingId != null && parkingId != "") {
				statement = con.prepareStatement("SELECT datePlaced, timePlaced, hour, booking.carId, numberPlate, name, price FROM booking INNER JOIN car ON booking.carId = car.carId WHERE booking.parkingId = ? AND completion = 0");
				statement.setString(1, parkingId);

				rs = statement.executeQuery();
				while (rs.next()) {
					
					dateTime = LocalDateTime.of(rs.getDate("datePlaced").toLocalDate(), rs.getTime("timePlaced").toLocalTime());
					dateT = dateTime.plusHours(Long.parseLong(rs.getString("hour"))).toString();
					time = dateT.split("T");
					
					out.println(
							"<div class='card h-100' style='width: 20rem; margin: 10px;'><img src=");
					out.println("'GetCarImage?carId=" + rs.getString("carId") + "'" + " class='card-img-top' style='height : 212px;' alt='...'><div class='card-body'><h5 class='card-title'> ");
					out.println(rs.getString("name"));
					out.println("</h5><p class='text-primary'>Number Plate :- " + rs.getString("numberPlate") );
					out.println("<br> Date Parking Ends :-" + time[0]);
					out.println("<br> Time Parking Ends :-" + time[1] );
					out.println("<br> Amount to be Collected :-" + rs.getString("price") + "</p>");
					out.println("</div></div>");
				}
			} else {
				out.println("</div>No cars are parked</div>");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

	%>

	</div>
	</div>



	<!-- Optional JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
		integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
		integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
		integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
		crossorigin="anonymous"></script>
</body>
</html>