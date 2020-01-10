<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name='viewport'
	content='width=device-width, initial-scale=1, shrink-to-fit=no'>

<!-- Bootstrap CSS -->
<link rel='stylesheet'
	href='https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css'
	integrity='sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm'
	crossorigin='anonymous'>
<link rel='stylesheet' href='css/style.css' />
<link rel='icon'
	href='https://upload.wikimedia.org/wikipedia/commons/thumb/5/52/Hong_Kong_road_sign_%28Parking%29.svg/768px-Hong_Kong_road_sign_%28Parking%29.svg.png' />

<title>Welcome to Park Me</title>
</head>
<body>

	<div class='container' style='margin-top:10px; padding: 10px;'>
		<form method="POST" action="AddCar" enctype="multipart/form-data">
			<p class="text-uppercase text-center">Fill in the details</p>
			<%
								if (application.getAttribute("addcars") != null) {
							%>
			<%=application.getAttribute("addcars")%>
			<%
								}
							%>
			<div class="form-row">
				<label for="inputName">Car Name</label> <input type="text"
					class="form-control" name="inputName" required>
			</div>
			<div class="form-row">
					<label for="inputPlate">Number Plate</label> <input type="text"
						class="form-control" name="inputPlate" required>
			</div>
			
			<div class="form-row" style="margin-top: 10px; margin-bottom: 10px;">
				<div class="custom-file">
					<input type="file" class="custom-file-input" id="image"
						name="image"> <label class="custom-file-label" for="image">Upload
						an image of your space</label>
				</div>
			</div>
			
			<div class="form-row">
			<button type="submit" class="btn btn-primary btn-block">Submit
				My Details</button>
				</div>
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
</body>
</html>