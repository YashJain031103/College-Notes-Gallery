<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Registration Form</title>
<link rel="stylesheet" href="register.css">
<style>
body {
  background-image : url("Gallery/openbook.jpg");
}
</style>
</head>
<body>
<%
String msg = (String) request.getAttribute("msg");
if(msg!=null){
%>
<h3 style="margin: 0 auto; width:250px; color:red; background-color:black; text-align:center;"><%=msg%></h3>
<%}
request.removeAttribute("msg");
%>
<div style="background-color:black; width: 200px; margin:0 auto;"><p id="errorMessage" style="color: red;text-align:center;"></p></div>
<div class="container" style="background-color: white; opacity: 0.8; width : 500px; height : 600px; font-size : 20px; text-align : center;" >
<marquee style="background-color:yellow">Kindly register yourself here to get access to the site, thank you ☺</marquee>
<h3 style="margin-left:0px ;background-color:red ; text-align:center">Register Here</h3>
<form action="Register" method="post" id="regform" onsubmit="return valid()">
Name: <input type="text" name="username" id="name" placeholder="enter your name"  required><br>
Email: <input type="email" name="email" id="email" placeholder="enter your email"  required><br>
Password: <input type="password" name="password" id="pass" placeholder="enter your password"><br>
<label for="department">select your department: </label>
<select name="department" id="department" >
<option value="cse">CSE</option>
<option value="ec">EC</option>
<option value="civil">Civil</option>
</select><br>
Choose your Category:<br>
<div><input type="radio" value="teacher" name="category" required>Teacher</div>
<div><input type="radio" value="student"  name="category" required>Student</div><br><br>
<button type="submit" form="regform" style="text-align: center; margin-left: 220px;">Register</button><br><br>
</form>
<div style="text-align:center"><a href="Login.jsp">Already User? Login here→</a></div>
</div>
<script>
function valid(){
	var name = document.getElementById("name").value;
	var email = document.getElementById("email").value;
	var passwf = document.getElementById("pass");
	var passw = passwf.value;
	if(name.trim()==""){
		document.getElementById("errorMessage").innerText="Name field is required!";
		return false;
	}
	if(email.trim()==""){
		document.getElementById("errorMessage").innerText="Email field is required!";
		return false;
	}
	if(/\s/.test(passw)){
		document.getElementById("errorMessage").innerText="Password should not contain white spaces";
		return false;
	}
	if(passw.trim()==""){
		document.getElementById("errorMessage").innerText="Password is Mandatory(No Blank Space Allowed)!";
		return false;
	}
	return true;
}

</script>
</body>
</html>