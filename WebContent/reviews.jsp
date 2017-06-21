<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>FTRB</title>
<link rel = "stylesheet" href = "css/bootstrap_theme.css"/>
<script src ="js/jquery.js"></script>
<script src ="js/bootstrap.js"></script>
<script src ="js/app.js"></script>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.*"%>
</head>
<body>
<div id="navigation"></div>

<div class="container">
   
		<h1 style="text-align:center; font-family:Copperplate gothic; font-weight:bold">Reviews Section </h1>      
		
        <img src="images/reviewcover1.jpg">
           
        </div>
<div id="review">
		<div class = "pull-right">
	<% 
	HttpSession check_session = request.getSession(false);
	String email = (String)session.getAttribute("email");
	if(email!=null){
		%>
		<h2>Logged in as: </h2>
		<p><%=email %>
		<%
	}
	
	
	else{
	%>
	<p style="margin-top:70px;">Please log in to write review</p>
	
	<%
	}
	%>
		<a href="write_review.jsp" class="btn btn-success" role="button">Post a review</a>


		</div>

<%
	HttpSession sortSession = request.getSession(false);
	List<Integer> sortedList = new ArrayList<Integer>();
	
	try{
		Class.forName("com.mysql.jdbc.Driver");

		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ftrb","root","root");
		PreparedStatement stmt = con.prepareStatement("select * from reviews order by rating desc");
		PreparedStatement name_stmt = con.prepareStatement("select name from login where user_id=?"); //displays in descending order

		ResultSet rs = stmt.executeQuery();
%>
		
		<table>
		<tr>
	
			
		
<%
		while(rs.next()){
%>

			<td>
			
			
			<div class="row">
			  <div class="col-sm-6 col-md-3">
			    <div class="thumbnail">
			      <img src="upload\<%=rs.getString("imageReview") %>" alt="Image">
			      <div class="caption">
			      
			        <h3><%=rs.getString("title")%></h3>
			          <% 
					        int user_id = rs.getInt("user_id");
					        String name=null;
					        name_stmt.setInt(1, user_id);
							ResultSet name_rs = name_stmt.executeQuery();
							while(name_rs.next()){
								
							 name = name_rs.getString("name");
					 %>
			 
		     
			        <p><b>Reviewed by : </b><%= name %></p>
			        <%}%>
			        <p><%=rs.getString("content")%></p>
			     	<p>Rating : <%=rs.getInt("rating")%>/5</p>
			     	
			       
			     	
								     
				 </div>
			  </div>
			</div>  
			</div>
			
			</td>
			
			
<% 	
	} %>	
		
		
		
		
			
			</tr>
		</table>
		</div>
		
		
<%
con.close(); 
	}catch(Exception e)
	{
		e.printStackTrace();
	}
%>
			
</body>
</html>