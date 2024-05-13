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
<title>Teacher Profile</title>
<link rel="stylesheet" href="profile.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" 
integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script>
function confirmDelete() {
    if (confirm("Are you sure you want to delete your account?")) {
           document.getElementById("DeleteAccount").submit();
        
    }
}
</script>
<style>
.dd {
  float: left;
  display: block;
  z-index:3;
}

.dd-c {
  display: none;
  position: absolute;
  background-color: #f9f9f9;
  min-width: 160px;
  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
  z-index: 3;
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
    <span class="dropbtn"><a style="color:white">Welcome,  ${session_name}</a></span>
    <div class="dd-c">
      <a href="Logout">Logout</a><br>
      <a href="Edit.jsp">Edit Profile</a><br>
      <a href="PassChange.jsp" >Change Password</a><br>
      <a href="#" onclick="confirmDelete()">Delete Account</a> 
      <form id="DeleteAccount" action="DeleteAccount" method="post"></form>
    </div>
  </div>
  <a href="Logout" class="right">Logout</a>
</div>

<div class="sidenav">
  <a href="Gallery.jsp">Notes Gallery</a>
  <a href="Upload.jsp">Upload Notes</a>
  <a href="ShowNotes.jsp">Show My Notes</a>
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
<%
String msg1 = (String) request.getAttribute("msg1");
if(msg1!=null){
%>
<h3 style="color:green; text-align:center;"><%=msg1%></h3>
<%}
request.removeAttribute("msg1");
%>
<%
String msg = (String) request.getAttribute("message");
if(msg!=null){
%>
<h3 style="color:green; text-align:center;"><%=msg%></h3>
<%}
request.removeAttribute("message");
%>
   <div class="container">
     <div class="row">
       <div class="col-md-12">
         
       </div>
     </div>
     <table class="table">
  <thead>
    <tr>
      <th scope="col">Author</th>
      <th scope="col">Title</th>
      <th scope="col">about</th>
      <th scope="col">Notes</th>
      <th scope="col">Action</th>
      <th scope="col">Approve</th>
    </tr>
  </thead>
  <tbody>
       <%
             Connection con = DbConnect.getCon();
             PreparedStatement ps = con.prepareStatement("Select * from notes where department_name=? and approve=? and category=?", ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
             ps.setString(1, (String)session.getAttribute("session_dept"));
             ps.setInt(2,0);
             ps.setString(3,"student");
             ResultSet r = ps.executeQuery();
             if(!r.next()){%>
            	  <tr><h3 style="color:red; text-align:center;">No Notes in Buffer For Approval!!</h3><br><br>
            	  </tr>
             <%}
             r.previous();
             while(r.next())
             {%>
            	 <tr>
            	     <th scope="row"><%= r.getString("email") %></th>
                     <td><%= r.getString("title") %></td>
                     <td><%= r.getString("about") %></td>
            	 <%
            	    if(r.getString("file").endsWith(".pdf"))
            	    {%>
            	    	<td><img alt="" src="notes/pdf.jpg" width="200px" height="100px"><br><p><%=r.getString("file")%></p></td>
            	    	<td>
            	    	<a href="DownloadFile?fn=<%=r.getString("file") %>" class="btn btn-sm btn-primary">Download</a>
            	    	</td>
            	    <%}else if(r.getString("file").endsWith(".txt"))
            	    {%>
            	    	<td><img alt="" src="notes/txt.png" width="200px" height="100px"><br><p><%=r.getString("file")%></p></td>
            	    	<td>
            	    	<a href="DownloadFile?fn=<%=r.getString("file") %>" class="btn btn-sm btn-primary">Download</a>
            	    	</td>
            	    <%}else if(r.getString("file").endsWith(".doc") || r.getString("file").endsWith(".docx"))
            	    {%>
            	    	<td><img alt="" src="notes/docx.jpg" width="200px" height="100px"><br><p><%=r.getString("file")%></p></td>
            	    	<td>
            	    	<a href="DownloadFile?fn=<%=r.getString("file") %>" class="btn btn-sm btn-primary">Download</a>
            	    	</td>
            	    <%}else if(r.getString("file").endsWith(".mp4"))
            	    {%>
            	    	<td><img alt="" src="notes/mp4.jpg" width="200px" height="100px"><br><p><%=r.getString("file")%></p></td>
            	    	<td>
            	    	<a href="DownloadFile?fn=<%=r.getString("file") %>" class="btn btn-sm btn-primary">Download</a>
            	    	</td>
            	    <%}
            	    else{%>
            	    	<td><img alt="" src="notes/<%=r.getString("file")%>" width="200px" height="100px"><br><p><%=r.getString("file")%></p></td>
            	    	<td>
            	    	<a href="DownloadFile?fn=<%=r.getString("file") %>" class="btn btn-sm btn-primary">Download</a>
            	    	</td>
            	    <%}%>
                        <td>
                        <form action="Approve" method="post">
                          <input type="hidden" name="timestamp" value="<%=r.getTimestamp("upload_time")%>">
                          <input type="hidden" name="author" value="<%=r.getString("email")%>">
                         <button type="submit">Approve</button>
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