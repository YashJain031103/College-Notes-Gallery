<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Upload Your Notes</title>
<link rel="stylesheet" href="profile.css">
<link rel="stylesheet" href="register.css">
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
<div style="background-color:black; width: 200px; margin:0 auto;"><p id="errorMessage" style="color: red;text-align:center;"></p></div>
<div class="containerx">
<marquee style="background-color:yellow">Kindly Maintain the Integrity of this platform and avoid uploading irrelevant Content here, thank you ☺</marquee>
<h3 style="margin-left:0px ;background-color:red ; text-align:center">Upload Your Notes Here</h3>
<form action="UploadNotes" onsubmit="return valid()" method="post" id="upform" enctype="multipart/form-data">
<label for="department">Content Belongs to which Department?: </label><br><br>
<select name="department" id="department" >
<option value="cse">CSE</option>
<option value="ec">EC</option>
<option value="civil">Civil</option>
</select><br><br>
<label for="title">Title of Your Notes: </label><br><br>
<input type="text" name="title" id="title" size="53" placeholder="Title of your notes, e.g. Thermodynamics" required><br><br>
<label for="about">Description of your Content: </label><br><br>
<textarea style="resize: none" name="about" id="about" rows="4" cols="50" placeholder="describe your content here" required></textarea><br><br>
<label for="type">Format of your Notes: </label><br><br>
<select name="type" id="type" >
<option value="video">Video</option>
<option value="document">Document</option>
</select><br><br>
<label for="file">Upload Content file: </label><br><br>
<input type="file" id="file" name="file" required><br><br>
<input style="margin-left:225px;text-align:center; background-color: #34568B ; color:white;" type="submit" id="upload" value="Upload" form="upform">
</form>
</div>
<script>
//accept=".txt, .pdf, .doc, .docx, .jpg, .jpeg, .png, .mp4" 
function valid(){
	var title = documen.getElementById("title").value;
	var about = documen.getElementById("about").value;
	var file = document.getElementById("file").value;
	var allowdoc = /(\.txt|\.pdf|\.doc|\.docx|\.jpg|\.jpeg|\.png)$/i;
	var allowvid = /(\.mp4)$/i;
	var type = document.getElementById("type").value;
	if(title.trim()==""){
		document.getElementById("errorMessage").innerText="Title field is required!";
		return false;
	}
	if(about.trim()==""){
		document.getElementById("errorMessage").innerText="Description field is required!";
		return false;
	}
	if(type=="document"){
		if(!allowdoc.exec(file)){
			document.getElementById("file").focus();
			document.getElementById("errorMessage").innerText="The allowed file Extensions are:- .txt, .pdf, .doc, .docx, .jpg, .jpeg, .png for document";
			file.value='';
			return false;
		}
	}
	if(type=="video"){
		if(!allowvid.exec(file)){
			document.getElementById("file").focus();
			document.getElementById("errorMessage").innerText="The allowed file Extensions are:- .mp4 for video";
			file.value='';
			return false;
		}
	}
	return true;
}
</script>
</body>
</html>