package com.ftrb;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

 
 
import org.apache.commons.fileupload.disk.DiskFileItemFactory;


/**
 * Servlet implementation class BlogServlet
 */
@WebServlet("/BlogServlet")
@MultipartConfig(maxFileSize = 16177215)
public class BlogServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final String UPLOAD_DIRECTORY = "upload";
	private static final int MEMORY_THRESHOLD   = 1024 * 1024 * 3;  // 3MB
    private static final int MAX_FILE_SIZE      = 1024 * 1024 * 40; // 40MB
    private static final int MAX_REQUEST_SIZE   = 1024 * 1024 * 50; // 50MB
 
	
    
    public BlogServlet() {
        super();
        
    }
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int id=0;
		String[] strArr = new String[5];
		
		
		try {
			
				File storeFile = null;	
				DiskFileItemFactory factory = new DiskFileItemFactory(DiskFileItemFactory.DEFAULT_SIZE_THRESHOLD, new File("C:\\Users\\Rohan\\git\\FTRB\\WebContent\\images"));
				factory.setSizeThreshold(MEMORY_THRESHOLD);
				factory.setRepository(new File(System.getProperty("java.io.tmpdir")));
				ServletFileUpload upload = new ServletFileUpload(factory);
				upload.setFileSizeMax(MAX_FILE_SIZE);

				upload.setSizeMax(MAX_REQUEST_SIZE);
				 String uploadPath = "C:\\Users\\Rohan\\workspace\\PuneFoodFunda\\WebContent\\" + UPLOAD_DIRECTORY; 
			                
				 
				 File uploadDir = new File(uploadPath);
			        if (!uploadDir.exists()) {
			            uploadDir.mkdir();
			        }
			 
				
					List<FileItem> list =  upload.parseRequest(request);
					
					if(list!=null && list.size()>0)
					{
				        int i=0;
		                int index = 0;
						for(FileItem item : list)
						{
							
							if(!item.isFormField())
							{
								
				                
								String fileName = new File(item.getName()).getName();
							    String filePath = uploadPath + File.separator + fileName;
		                        storeFile = new File(filePath);
		 
		                        // saves the file on disk
		                        item.write(storeFile);
		                    }
							else
							{
								 strArr[i] = item.getString();
								 i++;


							}
						}
					}
				
				
			String title = strArr[0];
			String para1 = strArr[1];
			String para2 = strArr[2];
			HttpSession session = request.getSession(false);
			String email = (String)session.getAttribute("email");
			Class.forName("com.mysql.jdbc.Driver"); 
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ftrb","root","root");
			PreparedStatement id_stmt = con.prepareStatement("select user_id from login where email=?"); //getting userid of the logged in user
			id_stmt.setString(1, email);
			ResultSet rs = id_stmt.executeQuery();
			while(rs.next())
			{
				 id = rs.getInt("user_id");
				
			}
			

			PreparedStatement stmt = con.prepareStatement("insert into blogs (title,para1,para2,user_id,imageBlog) values (?,?,?,?,?)"); //inserting user_id in blogs because user_id is our foreign key
			stmt.setString(1, title);
			stmt.setString(2, para1);
			stmt.setString(3, para2);
			stmt.setInt(4, id);
			stmt.setString(5,storeFile.getName());
			stmt.executeUpdate();
			response.sendRedirect("blogspot.jsp");
			//RequestDispatcher rd = request.getRequestDispatcher("blogspot.jsp");
			//rd.forward(request, response);				
			con.close();
			
		}catch(Exception e){ System.out.println(e);}  
					 
		}  
		
	}
		
		
