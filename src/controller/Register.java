package controller;

import java.io.File;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import db.InitDB;

/**
 * Servlet implementation class Register
 */
@WebServlet("/Register")
public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private PreparedStatement statement;
	/**
     * @see HttpServlet#HttpServlet()
     */
    public Register() {
        super();
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		FileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);
		List<FileItem> items = null;
		
		try {
			items = upload.parseRequest(request);

			Iterator<FileItem> iter = items.iterator();
			HashMap<String, String> formData = new HashMap<>();
			List<FileItem> fileData = new ArrayList<>();

			while (iter.hasNext()) {
				FileItem item = (FileItem) iter.next();

				if (item.isFormField()) {
					formData.put(item.getFieldName(), item.getString());
				} else {
					fileData.add(item);
				}
			}

			uploadImage(formData, fileData, request, response);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
	}

	private void uploadImage(HashMap<String, String> formData, List<FileItem> fileData, HttpServletRequest request,
			HttpServletResponse response) {
		String path = null;
		String finalimage = null;
		File savedFile = null;
		Iterator<FileItem> itr = fileData.iterator();

		try {
				FileItem item = (FileItem) itr.next();
				String itemName = item.getName();
				Random generator = new Random();
				int r = Math.abs(generator.nextInt());

				String reg = "[.*]";
				String replacingtext = "";
				Pattern pattern = Pattern.compile(reg);
				Matcher matcher = pattern.matcher(itemName);
				StringBuffer buffer = new StringBuffer();

				while (matcher.find()) {
					matcher.appendReplacement(buffer, replacingtext);
				}
				int IndexOf = itemName.indexOf("."); 
				String domainName = itemName.substring(IndexOf);

				finalimage = buffer.toString()+"_"+r+domainName;

				path = "home/atul/Projects/1_ServerData/userImages/";
				savedFile = new File(path +finalimage);
				item.write(savedFile);
				
				if(savedFile.exists())
					processFormData(formData, path + finalimage, request, response);
				
				
			}catch (Exception e) {
				System.out.println(e.getMessage());
			}
		
	}

	private void processFormData(HashMap<String, String> formData, String filePath, HttpServletRequest request,
			HttpServletResponse response) {
		String name = formData.get("name");
		String contact = formData.get("contact");
		String city = formData.get("city");
		String password = formData.get("password");
		String email = formData.get("email");
		String image = filePath;
		
		try {
			statement = InitDB.getConnection().prepareStatement("INSERT INTO user(name, city, contact, email, password, image) VALUES(?, ?, ?, ?, ?, ?)");
			statement.setString(1, name);
			statement.setString(2, city);
			statement.setString(3, contact);
			statement.setString(4, email);
			statement.setString(5, password);
			statement.setString(6, image);
			
			int action = statement.executeUpdate();
	        ServletContext sc = request.getServletContext();
			
			if(action > 0) {
				String htmlMessage = "<p class='text-center text-danger'>*** Account Created. ***</p>";
				
				sc.setAttribute("messages", htmlMessage);
		        response.sendRedirect("login.jsp");
			} else {
				String htmlMessage = "<p class='text-center text-danger'>*** Acccount Creation Failed ***</p>";
				sc.setAttribute("messages", htmlMessage);
		        response.sendRedirect("login.jsp#");
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}
