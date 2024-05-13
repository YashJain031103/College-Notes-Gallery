<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Profile</title>
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
String msg = (String) request.getAttribute("message");
if(msg!=null){
%>
<h3 style="color:red; text-align:center;"><%=msg%></h3>
<%}
request.removeAttribute("message");
%>
<div style="background-color:black; width: 200px; margin:0 auto;"><p id="errorMessage" style="color: red;text-align:center;"></p></div>
<div class="edit" id="mainContent">
<h2 style="text-align:center;">Edit Profile</h2>
<form action="Update" method="post" onsubmit="return valid()">
    <label for="username">Change Username:</label><br><br>
    <input type="text" id="username" name="name" value = ${session_name} required> <br><br>
    <input type="submit" value="Update">
</form>
</div>
<script>
function valid(){
	var username = document.getElementById("username").value.trim();
	if(username==""){
		document.getElementById("errorMessage").innerText="Username field is required!";
		return false;
	}
	return true;
}
</script>
</body>
</html>