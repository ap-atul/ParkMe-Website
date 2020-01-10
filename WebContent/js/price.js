
function cal() {
	var fare = document.getElementById("price").value;
	var inputHour = document.getElementById("inputHour").value;
	
	
	document.getElementById("priceOutput").value = fare * inputHour;
	document.getElementById("priceOutput").style.visibility = "visible";
}