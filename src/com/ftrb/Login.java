package com.ftrb;
import java.sql.*;
public class Login {
	public static boolean logIn(String email, String pwd) // function to check if user has registered or not
	{
		boolean status = false;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ftrb","root","root");
			PreparedStatement stmt = con.prepareStatement("select * from login where binary email=? and binary password=?");
			stmt.setString(1, email);
			stmt.setString(2, pwd);
			ResultSet rs = stmt.executeQuery();
			status = rs.next();			
			con.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return status;

	}
	}
