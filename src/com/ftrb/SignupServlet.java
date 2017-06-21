package com.ftrb;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class SignupServlet
 */
@WebServlet("/SignupServlet")
public class SignupServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SignupServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("signup_name");
		String email = request.getParameter("signup_email");
		String password = request.getParameter("signup_pwd");
		int i;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ftrb","root","root");
			PreparedStatement stmtSearch = con.prepareStatement("select * from login where email=?"); //to check if new user exists already or not		
			PreparedStatement stmt = con.prepareStatement("insert into login (password,email,name) values (?,?,?)");
			stmtSearch.setString(1, email);
			ResultSet rs = stmtSearch.executeQuery();
			if(!rs.next())
			{
				stmt.setString(1,password);
				stmt.setString(2,email);
				stmt.setString(3,name);
			    i = stmt.executeUpdate();
				if(i>0)
				{
					RequestDispatcher rd = request.getRequestDispatcher("login.html");
					rd.forward(request, response);

				}


			}
			else
			{
				RequestDispatcher rd = request.getRequestDispatcher("signup.html");
				rd.forward(request, response);

			}
			con.close();
						
		}catch(Exception e)
		{
			e.printStackTrace();
		}	}

}
