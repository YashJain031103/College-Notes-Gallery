<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.Connection" %>
    <%@ page import="java.sql.DriverManager" %>
    <%@ page import="in.sp.backend.DbConnect" %>
    <%@ page import="java.sql.PreparedStatement" %>
    <%@ page import="java.sql.ResultSet" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Profile</title>
<link rel="stylesheet" href="profile.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" 
integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<style>
.dd {
  float: left;
  display: block;
  z-index:2;
}

.dd-c {
  display: none;
  position: absolute;
  background-color: #f9f9f9;
  min-width: 160px;
  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
  z-index: 2;
}

.dd-c a {
  color: black;
  padding: 12px 16px;
  text-decoration: none;
  display: block;
  text-align: left;
  z-index: 2;
}

.dd-c a:hover {
  background-color: #f1f1f1;
  z-index: 2;
}

.dd:hover .dd-c {
  display: block;
  z-index: 2;
}
</style>
</head>
<body>
<div class="topnav">
  <div class="dd">
    <span class="dropbtn"><a style="color:white">Welcome,  ${admin_name}</a></span>
    <div class="dd-c">
      <a href="AdminLogout">Logout</a><br>
    </div>
  </div>
  <a href="AdminLogout" class="right">Logout</a>
</div>

<div class="sidenav">
  <a href="#">Manage Users</a>
  <a href="#">Manage Notes</a>
  <a href="#">Approved Teachers</a>
</div>

<div class="main" id="mainContent">
<%
String success = (String) request.getAttribute("success");
if(success!=null)
{%> 
	<h3 style="color:green; text-align:center;"><%=success%></h3>
<%}
request.removeAttribute("success");
%>
<%
String fail = (String) request.getAttribute("fail");
if(fail!=null)
{%>
	<h3 style="color:red; text-align:center;"><%=fail%></h3>
<%}
request.removeAttribute("fail");
%>
  <div class="container">
     <div class="row">
       <div class="col-md-12">
         
       </div>
     </div>
     <table class="table">
  <thead>
    <tr>
      <th scope="col">Name</th>
      <th scope="col">Email</th>
      <th scope="col">Department</th>
      <th scope="col">verify</th>
    </tr>
  </thead>
  <tbody>
       <%
             Connection con = DbConnect.getCon();
             PreparedStatement ps = con.prepareStatement("Select * from users where category=? and verify=?", ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
             ps.setString(1, "teacher");
             ps.setInt(2, 0);
             ResultSet r = ps.executeQuery();
             if(!r.next()){%>
       	  <tr><h3 style="color:red; text-align:center;">No Account Verification Request in buffer!!</h3><br>
      	  <!--<div style="color:purple; text-align:center;"><a href="Upload.jsp" class="btn btn-sm btn-primary">Click here to Upload</a></div>-->
       	  </tr>
           <%}%>
           <h3 style="color:purple;text-align:center">Account Verification requests</h3>
            <%r.previous();
             while(r.next())
             {%>
            	 <tr>
            	     <th scope="row"><%= r.getString("name") %></th>
                     <td><%= r.getString("email") %></td>
            	     <td><%= r.getString("department_name") %></td>
                        <td>
                        <form action="VerifyAcc" method="post">
                          <input type="hidden" name="email" value="<%=r.getString("email")%>">
                         <button type="submit">Verify</button>
                        </form>
                        </td>
                     </tr>
                    <%}%>
  </tbody>
</table>
     </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" 
integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" 
integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
</body>
</html>