<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Page</title>
<link rel="stylesheet" href="register.css">
<style>
body {
  background-image : url("Gallery/openbook.jpg");
}
</style>
</head>
<body>
<%
String msg1 = (String) request.getAttribute("msg1");
if(msg1!=null){
%>
<h3 style="color:green; text-align:center;"><%=msg1%></h3>
<%}
request.removeAttribute("msg1");
%>
<div style="background-color:black; width: 200px; margin:0 auto;"><p id="errorMessage" style="color: red;text-align:center;"></p></div>
<div class="container" style="background-color: white; opacity: 0.8; width : 300px; height : 300px; font-size : 20px; text-align : center;">
<marquee style="background-color:yellow">kindly enter your login credentials, thank you ☺</marquee>
<h3 style="margin-left:0px ;background-color:red ; text-align:center">Login Here</h3>
<form action="Login" method="post" id="logform" onsubmit="return valid()">
<input type="email" name="email" id="email" placeholder="enter your email" style="padding: 5px; width: 250px;" required><br><br>
<input type="password" name="password" id="pass" placeholder="enter your password" style="padding: 5px; width: 250px;" required><br><br>
<button type="submit" form="logform" value="submit" style="margin-left: 5px; padding: 5px; width: 100px;">Login</button><br><br>
</form>
<div style="text-align:center"><a href="Registration.jsp">Register Here→</a></div>
</div>
<script>
function valid(){
	var email = document.getElementByID("email").value.trim();
	var pass = document.getElementByID("pass").value.trim();
	if(email==""){
		document.getElementById("errorMessage").innerText="Email field is required!";
		return false;
	}
	if(pass==""){
		document.getElementById("errorMessage").innerText="Password field is required!";
		return false;
	}
	return true;
}
</script>
</body>
</html>