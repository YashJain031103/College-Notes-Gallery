<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>College Notes Gallery</title>
<link rel="stylesheet" href="profile.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" 
integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<style>
body {
  background-image : url("Gallery/Home.jpg");
  background-size : cover;
}
#about-pop{
display: none;
position: fixed;
top: 50%;
left: 50%;
transform: translate(-50%, -50%);
width: 800px;
background-color: white;
padding: 20px;
border: 1px solid #ccc;
}
.pop-content{
text-align: center;
}
#close-popup{
background-color: #333;
color: white;
padding: 10px 20px;
border: none;
cursor: pointer;
margin-top: 20px;
}
#close-popup:hover{
background-color: #555;
}
</style>
</head>
<body>
<div class="topnav">
    <span><a href="#">College Notes Gallery</a></span>
      <a href="Registration.jsp">Sign-Up</a>
      <a href="Login.jsp">Login</a>
      <a href="#" id="about" >About Us</a>
</div>
<div id="about-pop">
<div class="pop-content">
<h2>About Us</h2>
<p>Nowadays there is always a problem of getting good quality notes for studying 
especially for college and school going students. This thing can be a bit tension causing for a student during examination time. 
In order to avoid this there can be a system in which better quality notes can be obtained. 
This dynamic web application is created to share notes among scholar community where student and faculty of different departments and fields 
can come together to share their notes and content in the form of pdf, docs, and even video lecture. 
This develops strong community where people can share their knowledge and help other scholars to grow. 
This web application include the feature of upvote which prioritize the quality content on the top of the list.</p>
<p>Contact: notesgallery@gmail.com</p>
<p>Phone: +1234567890</p>
<button id="close-popup">Close</button>
</div>
</div>
<script>
document.getElementById('about').addEventListener('click',function(){
	document.getElementById('about-pop').style.display = 'block';
});
document.getElementById('close-popup').addEventListener('click', function(){
	document.getElementById('about-pop').style.display='none';
});
</script>
</body>
</html>