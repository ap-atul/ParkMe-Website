<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
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

	<div class='container' style='margin-top: 10px; padding: 10px;'>
		<form method="POST" action="AddParking" enctype="multipart/form-data">
			<p class="text-uppercase text-center">Fill in the details</p>
			<%
				if (application.getAttribute("rent") != null) {
			%>
			<%=application.getAttribute("rent")%>
			<%
				}
			%>
			<div class="form-group">
				<label for="inputEmail">Owner Full Name</label> <input type="text"
					class="form-control" name="inputName" required>
			</div>
			<div class="form-row">
				<div class="form-group col-md-6">
					<label for="inputEmail">Owner Email</label> <input type="email"
						class="form-control" name="inputEmail" required>
				</div>
				<div class="form-group col-md-6">
					<label for="inputContact">Owner Contact</label> <input type="text"
						class="form-control" name="inputContact" required>
				</div>
			</div>
			<div class="form-row">
				<div class="form-group col-md-6">
					<label for="inputSpots">Number of spots</label> <input
						type="number" class="form-control" name="inputSpots" required>
				</div>
				<div class="form-group col-md-6">
					<label for="inputFare">Fare (in Rs. for 1 hour)</label> <input
						type="number" class="form-control" name="inputFare" required>
				</div>
			</div>
			<div class="form-group">
				<label for="inputPlaceName">Place Name</label> <input type="text"
					class="form-control" name="inputPlaceName"
					placeholder="Shopping Mall" required>
			</div>
			<div class="form-group">
				<label for="inputAddress">Address Line 1</label> <input type="text"
					class="form-control" name="inputAddress" placeholder="1234 Main St"
					required>
			</div>
			<div class="form-group">
				<label for="inputAddress2">Address Line 2</label> <input type="text"
					class="form-control" name="inputAddress2"
					placeholder="Apartment, studio, or floor">
			</div>
			<div class="form-row">
				<div class="form-group col-md-6">
					<label for="inputCity">City</label> <input type="text"
						class="form-control" name="inputCity" required>
				</div>
				<div class="form-group col-md-4">
					<label for="inputState">State</label> <input type="text"
						class="form-control" name="inputState" required>
				</div>
				<div class="form-group col-md-2">
					<label for="inputZip">Zip</label> <input type="text"
						class="form-control" name="inputZip" required> <input
						type="hidden" class="form-control" name="lat" id="lat"> <input
						type="hidden" class="form-control" name="lng" id="lng">

				</div>
			</div>

			<div class="form-group">
				<div class="custom-file">
					<input type="file" class="custom-file-input" id="image"
						name="image"> <label class="custom-file-label" for="image">Upload
						an image of your space</label>
				</div>
			</div>


			<button type="submit" class="btn btn-primary btn-block">Submit
				My Details</button>
		</form>
	</div>

	<script type="text/javascript">
		document
				.getElementById("image")
				.addEventListener(
						"change",
						function(e) {
							document.querySelector("[for=" + e.target.id + "]").innerHTML = e.target.files[0].name;
						})
	</script>

	<!-- Optional JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script src="js/location.js"></script>
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