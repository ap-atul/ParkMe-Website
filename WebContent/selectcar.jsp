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
<script src="js/price.js"></script>
<link rel='icon'
	href='https://upload.wikimedia.org/wikipedia/commons/thumb/5/52/Hong_Kong_road_sign_%28Parking%29.svg/768px-Hong_Kong_road_sign_%28Parking%29.svg.png' />

<title>DashBoard</title>
</head>
<body>

	<%
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/parkme?useSSL=false", "root",
				"root");
		Cookie[] cookies = request.getCookies();

		String parkingId = null, fare = null;
		if (application.getAttribute("parkingId") != null) {
			parkingId = (String) application.getAttribute("parkingId");
		}

		//getting parking fare//
		PreparedStatement statement = con.prepareStatement("SELECT fare from parking where parkingId = ?");
		statement.setString(1, parkingId);

		ResultSet rs = statement.executeQuery();
		if (rs.next()) {
			fare = rs.getString("fare");
		}
		
		Cookie cookie = null;
		String userId = null;
		List<String> cars = new ArrayList<String>();
		List<String> carIds = new ArrayList<String>();

		if( cookies != null ) {
			for (int i = 0; i < cookies.length; i++) {
				cookie = cookies[i];
				if(cookie.getName().equals("userId")) {
					userId = cookie.getValue();
				}
			}
		} 
		
		try {
			if (userId != null) {
				statement = con.prepareStatement("SELECT carId, name from car where userId = ?");
				statement.setString(1, userId);

				rs = statement.executeQuery();
				
				while(rs.next()){
					cars.add(rs.getString("name"));
					carIds.add(rs.getString("carId"));
				}
			}
		}catch(Exception e){e.printStackTrace();}finally{
			con.close();
		}
	%>

	<div class='container' style='margin-top: 10px; padding: 10px;'>
		<form method="POST" action="AddBooking?parkingId=<%=parkingId %>">
			<p class="text-uppercase text-center">Fill in the details</p>
			<%
				out.println("<p class='badge badge-primary'>Parking Original Price :: " + fare + "</p>");
			%>
			<div class="form-row">
				<div class="form-group col-md-6">
					<label for="inputHour">Enter Number of Hours</label> <input
						type="number" min=1 value=1 class="form-control" name="inputHour"
						id="inputHour" required> <input type="hidden" name="price"
						id="price" value="<%out.println(fare);%>">
				</div>

				<div class="form-group col-md-6">
					<label for="priceOutput">Final Price (Rs.)</label> <input
						type="number" class="form-control" name="priceOutput"
						id="priceOutput" readonly="readonly">
				</div>


				<div class="form-row col-md-2">
					<button type="button" onClick="cal()"
						class="btn btn-primary btn-block">Calculate</button>
				</div>

			</div>

			<div class="form-row">
				<label for="car-option">Select car to book</label> <select
					class="form-control" name="carId">
					<%
						for(int i = 0; i < cars.size(); i++){
							out.println("<option value = '" + carIds.get(i) + "'>" + cars.get(i) + "</option>");
						}
					%>
				</select>
			</div>

			<div class="form-row">
				<button type="submit" class="btn btn-primary btn-block"
					style="margin-top: 10px;">Book</button>
			</div>

		</form>
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