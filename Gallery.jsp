<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>The Notes Gallery</title>
<link rel="stylesheet" href="profile.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
 integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
</head>
<body>
<div class="topnav">
  <a><span style="color:white">Welcome,  ${session_name}</span></a>
  <%
String category = (String) session.getAttribute("session_category");
if(category.equals("teacher")){%>
	<a href="TeacherProfile.jsp" class="right">Back to Profile</a>
<%}
else{%>
  <a href="Profile.jsp" class="right">Back to Profile</a>
  <%}%>
</div>
<div class="tab">
<table class="table">
  <thead>
    <tr>
      <th colspan="3" style="text-align:center;">Choose Your Stream of Interest</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th scope="row"><a href="CseNotes.jsp"><img alt="CSE" src="Gallery/CSE.jpg" width="300px" height="300px"></a><br><p>COMPUTER SCIENCE ENGINEERING</p></th>
      <th><a href="EcNotes.jsp"><img alt="ECE" src="Gallery/ECE.jpg" width="300px" height="300px"></a><br><p>ELECTRONICS AND COMMUNICATION</p></th>
      <th><a href="CivilNotes.jsp"><img alt="CIVIL" src="Gallery/CIVIL.jpg" width="300px" height="300px"></a><br><p>CIVIL ENGINEERING</p></th>
    </tr>
  </tbody>
</table>
</div>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" 
integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" 
integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
</body>
</html>