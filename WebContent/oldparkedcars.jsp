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
<link rel='stylesheet' href='css/bootstrap.min.css'>
<link rel="stylesheet" href="css/style.css" />
<link rel='icon' href='images/favicon.png' />

<title>DashBoard</title>
</head>
<body class="bg-light">
	<%
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/parkme?useSSL=false", "root",
				"root");

		String parkingId = request.getParameter("parkingId");

		PreparedStatement statement = null;
		ResultSet rs = null;

		LocalDateTime dateTime = null;
		String dateT = null, time[] = null;
	%>
	<section class="bg-dark text-center">
		<img src="GetImage?parkingId=<%out.println(parkingId);%> "
			style="height: 400px;">
	</section>

	<div class="container bg-light card-img-overlay" style="width: 80%; height: auto; margin-top: 25%;">
		<a class="badge badge-primary" href="dashboard.jsp"
			style="margin: 10px;">Go to DashBoard</a>
		<p class="badge badge-primary" style="margin: 10px;">All Parked
			Cars</p>


		<div class='container align-items-center'>
			<div class='row'>
				<%
					try {
						if (parkingId != null && parkingId != "") {
							statement = con.prepareStatement(
									"SELECT datePlaced, timePlaced, hour, booking.carId, numberPlate, name, price FROM booking INNER JOIN car ON booking.carId = car.carId WHERE booking.parkingId = ? AND completion = 1");
							statement.setString(1, parkingId);

							rs = statement.executeQuery();
							while (rs.next()) {

								dateTime = LocalDateTime.of(rs.getDate("datePlaced").toLocalDate(),
										rs.getTime("timePlaced").toLocalTime());
								dateT = dateTime.plusHours(Long.parseLong(rs.getString("hour"))).toString();
								time = dateT.split("T");

								out.println("<div class='shadow card h-100' style='width: 20rem; margin: 10px;'><img src=");
								out.println("'GetCarImage?carId=" + rs.getString("carId") + "'"
										+ " class='card-img-top' style='height : 212px;' alt='...'><div class='card-body'><h5 class='card-title'> ");
								out.println(rs.getString("name"));
								out.println("</h5><p class='text-primary'>Number Plate :- " + rs.getString("numberPlate"));
								out.println("<br> Date Parking Ends :-" + time[0]);
								out.println("<br> Time Parking Ends :-" + time[1]);
								out.println("<br> Amount to be Collected :-" + rs.getString("price") + "</p>");
								out.println("</div></div>");
							}
						} else {
							out.println("</div>No cars are parked</div>");
						}
					} catch (SQLException e) {
						e.printStackTrace();
					} finally {
						con.close();
					}
				%>

			</div>
		</div>
	</div>



	<!-- Optional JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script type="text/javascript" src="js/jquery.js"></script>
	<script type="text/javascript" src="js/popper.js"></script>
	<script type="text/javascript" src="js/bootstrap.min.js"></script>
</body>
</html>