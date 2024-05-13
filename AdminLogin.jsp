<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Login Page</title>
<link rel="stylesheet" href="register.css">
<style>
body {
  background-image : url("Gallery/openbook.jpg");
  background-size : cover;
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
<div class="container">
<marquee style="background-color:yellow">kindly enter your login credentials, thank you ☺</marquee>
<h3 style="margin-left:0px ;background-color:red ; text-align:center">Admin Login Here</h3>
<form action="AdminLogin" method="post" id="logform" onsubmit="return valid()">
<input type="text" name="username" id="username" placeholder="enter your username" required><br><br>
<input type="password" name="password" id="pass" placeholder="enter your password" required><br><br>
<button type="submit" form="logform" value="submit" id="log" style="margin-left: 40px; padding: 5px; width: 100px;">Login</button><br><br>
</form>
</div>
<script>
function valid(){
	var username = document.getElementById("username").value.trim();
	var pass = document.getElementById("pass").value.trim();
	if(username=""){
		document.getElementById("errorMessage").innerText="Username field is required!";
		return false;
	}
	if(pass=""){
		document.getElementById("errorMessage").innerText="Password field is required!";
		return false;
	}
	return true;
}
</script>
</body>
</html>