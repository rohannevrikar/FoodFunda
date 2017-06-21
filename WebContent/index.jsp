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

<title>Insert title here</title>
<link rel = "stylesheet" href = "css/bootstrap_theme.css"/>
<script src ="js/jquery.js"></script>
<script src ="js/bootstrap.js"></script>
<script src = "js/app.js"></script>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>

<body>

   <div id="navigation"></div>
   <div id="blog">
		<div class = "pull-right">
	<% 
		HttpSession readSession = null; //making a new session
		HttpSession check_session = request.getSession(false); //to get the existing session
		String email = (String)check_session.getAttribute("email");
		if(email!=null){
			%>
			<h2>Logged in as: </h2>
			<p><%=email %>
		
			<%
		}
		
		
		else{
	%>
	<p style="margin-top:70px;">Please log in to write your own review or blog</p>
	<a href="write_blog.jsp" class="btn btn-success" role="button">Log In</a>
	
	
	<%
		}
	%>
		

		</div>

    
   
   <%
	try{
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ftrb","root","root");
		PreparedStatement blog_stmt = con.prepareStatement("select * from blogs ");
		PreparedStatement blog_name_stmt = con.prepareStatement("select name from login where user_id=?");
		PreparedStatement review_stmt = con.prepareStatement("select * from reviews order by rating desc");
		PreparedStatement review_name_stmt = con.prepareStatement("select name from login where user_id=?");

		ResultSet blog_rs = blog_stmt.executeQuery();
		ResultSet review_rs = review_stmt.executeQuery();
		
%>
		  <h2 style="margin-left:100px; margin-top:70px;font-family:Copperplate gothic">Top rated restaurants!</h2>
		<table>
		<tr>
	<%
	int countReview=0;
		while(review_rs.next()){
%>

			<td>
			
			
			<div class="row">
			  <div class="col-sm-6 col-md-3">
			    <div class="thumbnail">
			      <img src="images/food.jpg" alt="...">
			      <div class="caption">
			      
			        <h3><%=review_rs.getString("title")%></h3>
			          <% 
				        int user_id = review_rs.getInt("user_id");
				        String name=null;
				        review_name_stmt.setInt(1, user_id);
						ResultSet name_rs = review_name_stmt.executeQuery();
						countReview++;
						while(name_rs.next()){
						
					    	name = name_rs.getString("name");%> 		     
			        		<p><b>Reviewed by : </b><%= name %></p>
			        <%}%>
			        
			        <p><%=review_rs.getString("content")%></p>
			     	<p>Rating : <%=review_rs.getInt("rating")%>/5</p>	     	
			       
			     	
								     
				 </div>
				
					
			  </div>
			</div>  
			</div>
			
			
			</td>
			
			
			<% if(countReview==2) // to get top 2 reviews
				break;

} %>
	</tr>
	</table>
			
   <h2 style="margin-left:100px; margin-top:70px;font-family:Copperplate gothic">Top blogs</h2>
   <table>
		<tr>
		
<%
		int count_blogs = 0;

		while(blog_rs.next()){
%>

			<td>
			
			
			
			<div class="row">
			  <div class="col-sm-6 col-md-3">
			    <div class="thumbnail">
			      <img src="images/blog1.jpg" alt="...">
			      <div class="caption">
			      
			        <h3><%=blog_rs.getString("title")%></h3>
			       <% 
			      
			       
				        int id = blog_rs.getInt("blog_id");
				        int user_id = blog_rs.getInt("user_id");
				        String name=null;
				        blog_name_stmt.setInt(1, user_id);
						ResultSet name_rs = blog_name_stmt.executeQuery();
						while(name_rs.next()){
							
							 name = name_rs.getString("name");%> 
				     
					        <p><b>Written by : </b><%= name %></p>
				        <%}
					    count_blogs++;
					    System.out.println(id);	
					%>
					
			        <form action = "read_blog.jsp" method = "post">
			        		<input type="hidden" name="btnRead" value="<%=id %>"/>
			        		<input type="hidden" name="name" value="<%=name %>"/>
			        	     <%
					         	
					        	/*System.out.println(id);
					        	readSession = request.getSession(); //creating a new session
					        	readSession.setAttribute("readbtn", id); //setting the id of the clicked blog 
					        	readSession.setAttribute("name", name); //setting name of the logged in user
					        	readSession.setAttribute("blogCount", count_blogs);*/ //count the total blogs in resultset
						        
					         %>
					         <input type="submit" class="btn btn-success" value="Read blog"/>
								
							</form>
					        
					<% 
						if(count_blogs==2) //to get 2 blogs
						break;
					%>
				
				</div>	
			  </div>
			</div>  
			</div>
			
			
			</td>
			
			

	<% 	
	} %>	
		
		
		
			
			</tr>
		</table>
		
<%	con.close(); 	
	}catch(Exception e)
	{
		e.printStackTrace();
	}
	
%>
   
   </div> 
</body>
</html>