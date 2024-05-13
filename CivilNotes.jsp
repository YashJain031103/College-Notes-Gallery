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
<title>Civil Engineering</title>
<link rel="stylesheet" href="profile.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" 
integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
</head>
<body>
<div class="topnav">
  <a href="Gallery.jsp" class="right">Back</a>
</div>
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
String voted = (String) request.getAttribute("voted");
if(voted!=null)
{%>
	<h3 style="color:red; text-align:center;"><%=voted%></h3>
<%}
request.removeAttribute("voted");
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
      <th scope="col">Author</th>
      <th scope="col">Title</th>
      <th scope="col">about</th>
      <th scope="col">Notes</th>
      <th scope="col">Action</th>
      <th scope="col">Upvote</th>
    </tr>
  </thead>
  <tbody>
       <%
             Connection con = DbConnect.getCon();
       PreparedStatement ps = con.prepareStatement("Select * from notes where department_name=? and (approve=? or category=?) order by upvote desc", ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
       ps.setString(1,"civil");
       ps.setInt(2,1);
       ps.setString(3, "teacher");
       ResultSet r = ps.executeQuery();
       if(!r.next()){%>
      	  <tr><h3 style="color:red; text-align:center;">No Records Found in the Table</h3><br><br>
      	  <h3 style="color:purple; text-align:center;">Be the First to Contribute to this Department</h3><br>
      	  <div style="color:purple; text-align:center;"><a href="Upload.jsp" class="btn btn-sm btn-primary">Click here to Upload</a></div>
      	  </tr>
           <%}
          r.previous();
             while(r.next())
             {%>
            	 <tr>
            	     <th scope="row"><%if(r.getString("category").equals("teacher")){%><p>&#9733;</p><%}%><%= r.getString("email") %></th>
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
                        <form action="Upvote" method="post">
                          <input type="hidden" name="timestamp" value="<%=r.getTimestamp("upload_time")%>">
                          <input type="hidden" name="author" value="<%=r.getString("email")%>">
                          <input type="hidden" name="department" value="CivilNotes">
                         <button type="submit">Upvote</button><p><%=r.getString("upvote")%></p>
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