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
<script src = "js/app.js"></script>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.io.*"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>

</head>
<body>
	<div id="navigation"></div>
	<div class="container">
	   
			<h1 style="text-align:center; font-family:Copperplate gothic; font-weight:bold">Blog Section </h1>      
			
	        <img src="images/blogcover.jpg">
	           
	</div>
	
	<div id="blog">
			<div class = "pull-right">
			
			<% 
				HttpSession readSession  = request.getSession(); //creating new session 
;
				HttpSession check_session = request.getSession(false); //getting the existing session 
				String email = (String)check_session.getAttribute("email");
				if(email!=null){
			%>
					<h2>Logged in as: </h2>
					<p><%=email %>
			<%
				}
				
				
				else{
			%>
				<p style="margin-top:70px;">Please log in to write your own blog</p>
			
			<%
				}
			%>
				<a href="write_blog.jsp" class="btn btn-success" role="button">Write your own blog</a>			
				</div>
		
	<%
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ftrb","root","root");
			PreparedStatement stmt = con.prepareStatement("select * from blogs ");
			PreparedStatement name_stmt = con.prepareStatement("select name from login where user_id=?");			
			ResultSet rs = stmt.executeQuery();
			
	%>
			
			<table>
			<tr>
						
	<%
			int count_blogs = 0;
			
			while(rs.next()){
	%>
	
				<td>
				
				
				
				<div class="row">
				  <div class="col-xs-6 col-md-3">
				    <div class="thumbnail">
				    
				       <img src="upload\<%=rs.getString("imageBlog")%>" class="portrait" alt="image">
				       <div class="caption">				      
				      
					        <h3><%=rs.getString("title")%></h3>
					       <% 
					      
					       
						       int id = rs.getInt("blog_id");
						       int user_id = rs.getInt("user_id");
						       String name=null;
						       name_stmt.setInt(1, user_id);
							   ResultSet name_rs = name_stmt.executeQuery();
							   
							   while(name_rs.next())
							   {
								   
									 name = name_rs.getString("name");%>			 
						     
							        <p><b>Written by : </b><%= name %></p>
						     <%}
							   count_blogs++;
							
							 %>
					         <form action = "read_blog.jsp" method = "post">
					         <input type="hidden" name="btnRead" value="<%=id %>"/>
			        		 <input type="hidden" name="name" value="<%=name %>"/>
			        	   
					         <%
					        	/*readSession.setAttribute("readbtn", id); //setting id of the clicked blog
					        	readSession.setAttribute("name", name); //setting name of the logged in user  
					        	readSession.setAttribute("blogCount", count_blogs);*/ //setting number of blogs in resultset
						        
					         %>
					        
							
							<input type="submit" class="btn btn-success" value="Read blog"/>
								
							</form>
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