<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel = "stylesheet" href = "css/bootstrap_theme.css"/>
<script src ="js/jquery.js"></script>

<script src ="js/bootstrap.js"></script>
<script src = "js/app.js"></script>
</head>
<body>
<div class="writer">
<div class="pull-right">
<%
	HttpSession check_session = request.getSession(false);
	String email = (String)check_session.getAttribute("email");
	if(email!=null){
		%>
		<h2>Logged in as: </h2>
		<p><%=email %>
		<%
	}
	else
	{
		response.sendRedirect("login.html");
	}
	%>
	
		

</div>
</div>
<div id="navigation"></div>
<div class="write">
<form action="BlogServlet" method = "post" enctype="multipart/form-data">
<div id="title">

<h3>Title of your blog</h3>
 <textarea style="height:30px; width:250px;" name="title"></textarea>
<p>Upload cover image</p>
<input type="file" name="imageBlog"/>
</div>
<br><br>
<h3>Content of the blog</h3>
<div id="paragraph-1">

<h4>Paragraph 1</h4>
  <textarea style="height:300px; width:500px;" id="paragraph" name="paragraph1"></textarea>
</div>
<br><br>
<div id="paragraph-2" style="padding-top:30px">
<h4>Paragraph 2</h4>
  <textarea style="height:300px; width:500px;" id="paragraph" name="paragraph2"></textarea>

</div>

<button type="submit" class="btn btn-success" id="blog_button" style="clear:both">Submit</button>
</form>

</div>
</body>
</html>