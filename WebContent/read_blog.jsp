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
</head>
<body>
	<div id="navigation"></div>
	<%
		String i = request.getParameter("btnRead");
	    System.out.println(i);
		int check_id = Integer.parseInt(i);
		String name = request.getParameter("name");
		/*HttpSession readSession = request.getSession(false);
		Integer i = (Integer)readSession.getAttribute("readbtn"); //id of the clicked blog
		int check_id = i; //unboxing the id
		System.out.println(check_id);
		Integer blogCount = (Integer)readSession.getAttribute("blogCount"); 
		int blog_count = blogCount;
		String name = (String)readSession.getAttribute("name");*/ //name of the author of the blog
		
		try {
					Class.forName("com.mysql.jdbc.Driver");
					Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ftrb","root","root");
				
			
					PreparedStatement stmt = con.prepareStatement("select * from blogs where blog_id=?");					
					stmt.setInt(1,check_id);
					ResultSet rs = stmt.executeQuery();%>
					
					<div id="blog_read">
					<%
						while(rs.next()){
					%>
						
						<h3><%=rs.getString("title") %></h3>
						<p><%=rs.getString("para1") %></p>
			     		 <img src="upload\<%=rs.getString("imageBlog") %>" alt="Image">
						<p><%=rs.getString("para2") %></p>
						<p><b>Written by : </b><%=name %></p>
								
	<%} %>
				</div>
		
	<%	
		con.close();
	} catch (Exception e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
	}
	%>

</body>
