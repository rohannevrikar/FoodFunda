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
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class ImageUpload {
	
		
	
		private static final long serialVersionUID = 1L;
		private final String UPLOAD_DIRECTORY = "upload";
		public String[] strArr;
		private static final int MEMORY_THRESHOLD   = 1024 * 1024 * 3;  // 3MB
	    private static final int MAX_FILE_SIZE      = 1024 * 1024 * 40; // 40MB
	    private static final int MAX_REQUEST_SIZE   = 1024 * 1024 * 50; // 50MB
	
		public File imageUpload() throws ServletException, IOException {
	
	 
	    strArr = new String[5];
		
		File storeFile = null;	
	
	try {
			HttpServletRequest request = null;
		
			DiskFileItemFactory factory = new DiskFileItemFactory(DiskFileItemFactory.DEFAULT_SIZE_THRESHOLD, new File("C:\\Users\\Rohan\\git\\FTRB\\WebContent\\images"));
			factory.setSizeThreshold(MEMORY_THRESHOLD);
			factory.setRepository(new File(System.getProperty("java.io.tmpdir")));
			ServletFileUpload upload = new ServletFileUpload(factory);
			upload.setFileSizeMax(MAX_FILE_SIZE);

			upload.setSizeMax(MAX_REQUEST_SIZE);
			 String uploadPath = "C:\\Users\\Rohan\\git\\FTRB\\WebContent\\" + UPLOAD_DIRECTORY; 
		                
			 
			 File uploadDir = new File(uploadPath);
		        if (!uploadDir.exists()) {
		            uploadDir.mkdir();
		        }
		 
			
				List<FileItem> list =  upload.parseRequest(request);
				
				if(list!=null && list.size()>0)
				{
					System.out.println("If");
	                int i=0;
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

		
	}catch(Exception e){ System.out.println(e);}
	return storeFile;
	  
				 
	}  
	
}
	



