<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name='viewport'
	content='width=device-width, initial-scale=1, shrink-to-fit=no'>

<!-- Bootstrap CSS -->
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/style.css" />
<link rel="icon" href="images/favicon.png" />

<title>Welcome to Park Me</title>
</head>
<body>

	<div class='container' style='margin-top: 10px; padding: 10px;'>
		<form method="POST" action="AddCar" enctype="multipart/form-data">
			<p class="text-uppercase text-center">Fill in the details</p>
			<%
				if (application.getAttribute("addcars") != null) {
			%>
			<%=application.getAttribute("addcars")%>
			<%
				application.removeAttribute("addcars");
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