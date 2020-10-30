<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/style.css" />
<link rel="icon" href="images/favicon.png" />

<title>Welcome to Park Me</title>
</head>
<body>

	<!-- 	Navigation Bar -->
	<nav class="navbar navbar-expand-md navbar-dark bg-primary">
		<a class="navbar-brand" href="index.jsp">Park <span
			class="brand-span">ME</span></a>
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
				<li class="nav-item active"><a class="nav-link" href="#about">About</a></li>
				<li class="nav-item active"><a class="nav-link" href="#contact">Contact</a></li>
			</ul>
			<ul class="navbar-nav ml-auto">
				<li class="nav-item active login-text"><a class="nav-link"
					href="login.jsp">Login</a></li>
			</ul>
		</div>
	</nav>

	<!-- Background image and name title -->
	<section class="bg-black hero-section set-bg">
		<div class="hero-text text-light title">
			<h1>WELCOME TO PARKME</h1>
            <h2>Renting a Parking Space</h2>
            <h4>Provide your own area for others to park
                and make a earning out of it.</h4>
            <a target="new" href="rentmyspace.jsp"><button
                class="btn btn-primary border text-secondary-title text-white py-2 px-3">Rent My Space</button></a>
                <br />
                <br />
            <h2>Finding a Parking Space</h2>
            <h4>Choose your respective location and select
                one of the available spaces, park your vehicle and we will take
                care of your property.</h4>
            <a target="new" href="parkmyvehicle.jsp"><button
                class="btn btn-primary border text-secondary-title text-white py-2 px-3">Park My Vehicle</button></a>
		</div>
	</section>

	<!-- About Us  -->
	<div class="container" style="margin-top: 100px;">
		<div class="row no-gutters">
			<div class="col-lg-4">
				<img src="images/aboutus.png" class="card-img" alt="about us">
			</div>
			<div class="col-md-8">
				<div class="card-body">
					<h5 class="card-title text-dark mb-4">About Us</h5>
					<p class="card-text text-primary">ParkM’s fast, simple and easy
						to use system allows your residents to self-manage parking 24
						hours a day 7 days a week. Residents can manage their vehicles as
						well as purchase guest permits for their visitors, all online
						through their own secure login. ParkM is a virtual permitting
						system, no more hanging tags to get lost or stickers that
						residents don’t like putting in their cars windshield. All
						permitting is tied to the registered license plate which
						eliminates the need for paper permits. Through the ParkM system
						property managers can see exactly who is parking at the community
						and which vehicles are not permitted to park on site. With ParkM,
						property managers can look up a car online and instantly see who
						owns the car and what unit they live in. The manager can then
						alert the resident if they need to temporarily move their car for
						things like lot resurfacing or property construction. No more
						calling the tow co mpany to relocate cars. Clean up your parking
						lot with ParkM virtual parking permits.</p>
				</div>
			</div>
		</div>
	</div>

	<!-- Contact Us -->
	<div class="container bg-primary text-light" style="padding-top:10%; max-width: 100%; padding-bottom: 10%">
		<div class="row justify-content-center text-center">
			<div class="text-center">
				<h2 class="card-title">Contact Us</h2>
				<p class="card-text">For any queries, please feel free to
					contact us using the form or the contact details!</p>
			</div>
		</div>
		<div class="row" style="padding-top: 5%;">
			<div class="col-lg-8 mb-5">
				<form method="POST" action="Contact">
					<div class="form-group row">
						<div class="col-md-6 mb-4 mb-lg-0">
							<input name="fname" type="text" class="form-control"
								placeholder="First name" required>
						</div>
						<div class="col-md-6">
							<input name="lname" type="text" class="form-control"
								placeholder="Last name" required>
						</div>
					</div>

					<div class="form-group row">
						<div class="col-md-12">
							<input name="email" type="text" class="form-control"
								placeholder="Email address" required>
						</div>
					</div>

					<div class="form-group row">
						<div class="col-md-12">
							<textarea name="message" class="form-control"
								placeholder="Write your message." cols="30" rows="10" required></textarea>
						</div>
					</div>
					<div class="form-group row">
						<div class="col-md-6 mr-auto">
							<input type="submit"
								class="btn btn-block btn-light text-primary border-dark py-3 px-5"
								value="Submit">
						</div>
					</div>
					<%
						if (application.getAttribute("contact") != null) {
					%>
					<%=application.getAttribute("contact")%>
					<%
						application.removeAttribute("contact");
						}
					%>
				</form>

			</div>
			<div class="col-lg-4 ml-auto">
				<div class="bg-white p-3 p-md-5">
					<h3 class="text-dark mb-4">Contact Info</h3>
					<ul class="list-unstyled footer-link">
						<li class="d-block mb-3"><span class="d-block text-black">Address:</span>
							<span class="text-dark">Katraj, Pune, India</span></li>
						<li class="d-block mb-3"><span class="d-block text-black">Phone:</span><span
							class="text-dark">+1 123 123 1234</span></li>
						<li class="d-block mb-3"><span class="d-block text-black">Email:</span><span
							class="text-dark">info@parkme.com</span></li>
					</ul>
				</div>
			</div>
		</div>
	</div>

	<!-- Optional JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script src="js/jquery.js"></script>
	<script src="js/popper.js"></script>
	<script src="js/bootstrap.min.js"></script>
</body>
</html>
