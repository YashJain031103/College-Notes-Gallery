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
<title>Show My Notes</title>
<link rel="stylesheet" href="profile.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" 
integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
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
String msg1 = (String) request.getAttribute("msg1");
if(msg1!=null){
%>
<h3 style="color:green; text-align:center;"><%=msg1%></h3>
<%}
request.removeAttribute("msg1");
%>
<%
String msg = (String) request.getAttribute("msg");
if(msg!=null){
%>
<h3 style="color:red; text-align:center;"><%=msg%></h3>
<%}
request.removeAttribute("msg");
%>
     <div class="container">
     <div class="row">
       <div class="col-md-12">
         
       </div>
     </div>
     <table class="table">
  <thead>
    <tr>
      <th scope="col">Department</th>
      <th scope="col">Title</th>
      <th scope="col">Notes</th>
      <th scope="col">Action</th>
      <th scope="col">TimeStamp</th>
      <th scope="col">Delete Notes</th>
    </tr>
  </thead>
  <tbody>
       <%
             Connection con = DbConnect.getCon();
             PreparedStatement ps = con.prepareStatement("Select * from notes where email=? and (approve=? or category=?)", ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
             ps.setString(1, (String)session.getAttribute("session_email"));
             ps.setInt(2,1);
             ps.setString(3, "teacher");
             ResultSet r = ps.executeQuery();
             if(!r.next()){%>
       	  <tr><h3 style="color:red; text-align:center;">You Haven't uploaded any Notes yet</h3><br>
      	  <div style="color:purple; text-align:center;"><a href="Upload.jsp" class="btn btn-sm btn-primary">Click here to Upload</a></div>
       	  </tr>
           <%}
            r.previous();
             while(r.next())
             {%>
            	 <tr>
            	     <th scope="row"><%= r.getString("department_name") %></th>
                     <td><%= r.getString("title") %></td>
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
                        <td><%= r.getTimestamp("upload_time") %></td>
                        <td>
                        <form action="DeleteRec" method="post">
                          <input type="hidden" name="timestamp" value="<%=r.getTimestamp("upload_time")%>">
                         <button type="submit">Delete</button>
                        </form>
                        </td>
                     </tr>
                    <%}%>
  </tbody>
</table>
     </div>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" 
integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" 
integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
</body>
</html>