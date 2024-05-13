<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Change Password</title>
<link rel="stylesheet" href="profile.css">
<link rel="stylesheet" href="edit.css">
</head>
<body>
<div class="topnav">
  <%
String category = (String) session.getAttribute("session_category");
if(category.equals("teacher")){%>
	<a href="TeacherProfile.jsp" class="right">Back to Profile</a>
<%}
else{%>
  <a href="Profile.jsp" class="right">Back to Profile</a>
  <%}%>
</div>
<%
String msg = (String) request.getAttribute("msg");
if(msg!=null){
%>
<h3 style="color:red; text-align:center;"><%=msg%></h3>
<%}
request.removeAttribute("msg");
%>
<div style="background-color:black; width: 200px; margin:0 auto;"><p id="errorMessage" style="color: red;text-align:center;"></p></div>
<div class="edit" id="mainContent">
<h2 style="text-align:center;">Change Password</h2>
<form action="PassChange" method="post" onsubmit="return valid()">
    <label for="CurrPass">Enter your Current Password</label><br><br>
    <input type="password" id="CurrPass" name="CurrPass"> <br><br>
    <label for="NewPass">Enter your New Password</label><br><br>
    <input type="password" id="NewPass" name="NewPass"> <br><br>
    <input type="submit" value="Change Password">
</form>
</div>
<script>
function valid(){
	var curpas = document.getElementById("CurrPass").value;
	var newpasf = document.getElementById("NewPass");
	var newpas = newpasf.value;
	if(curpas==""){
		document.getElementById("errorMessage").innerText="Kindly Enter Your Current Password!";
		return false;
	}
	if(curpas.trim()==""){
		document.getElementById("errorMessage").innerText="No Blank Space Allowed in the Password Field!";
		return false;
	}
	if(newpas==""){
		document.getElementById("errorMessage").innerText="Kindly Enter Your New Password!";
		return false;
	}
	if(newpas.trim()==""){
		document.getElementById("errorMessage").innerText="No Blank Space Allowed in the Password Field!";
		return false;
	}
	if(/\s/.test(newpas)){
		document.getElementById("errorMessage").innerText="Password should not contain white spaces";
		return false;
	}
	return true;
}
</script>
</body>
</html>