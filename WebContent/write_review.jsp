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
<form action="ReviewServlet" method = "post" enctype="multipart/form-data">

<br><br>
<div id="review" style="clear:both; padding-top:30px;">
<h3>Title of your review</h3>
 <textarea style="height:30px; width:250px;" name="title" maxlength="40" required></textarea>
 <p>Upload image</p>
<input type="file" name="imageReview"/>
<br><br>
<h4>Write something about this place and it's food </h4> <p>(Max 200 characters)</p>
  <textarea style="height:200px; width:300px;" id="paragraph" name="content" maxlength="200" required></textarea>
<br><br>
<h4>On the scale of 5, how would you rate this place and it's food?</h4>
<select name="rating">
<option value="1">1</option>
<option value="2">2</option>
<option value="3">3</option>
<option value="4">4</option>
<option value="5">5</option>
</select>
</div>

<br>


<button type="submit" class="btn btn-success" id="blog_button" style="clear:both">Submit</button>
</form>

</div>
</body>
</html>