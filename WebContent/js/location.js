window.onload = function() {
	checkCookie();

	if (navigator.geolocation) {
		navigator.geolocation.getCurrentPosition(function (position) {
			document.getElementById("lat").value =  position.coords.latitude;
			document.getElementById("lng").value =  position.coords.longitude;
		});
	} else {
		x.innerHTML = "Geolocation is not supported by this browser.";
	}

	console.log(document.getElementById("lat").value);
	console.log(document.getElementById("lng").value);
}

function checkCookie() {
	var username = getCookie("userId");

	if (username == "") {
		window.location = "login.jsp"
	}
	return;
}

function getCookie(cname) {
	var name = cname + "=";
	var decodedCookie = decodeURIComponent(document.cookie);
	var ca = decodedCookie.split(';');
	for(var i = 0; i <ca.length; i++) {
		var c = ca[i];
		while (c.charAt(0) == ' ') {
			c = c.substring(1);
		}
		if (c.indexOf(name) == 0) {
			return c.substring(name.length, c.length);
		}
	}
	return "";
}