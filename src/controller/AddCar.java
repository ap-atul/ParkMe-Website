package controller;

import java.io.File;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.SQLException;
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
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import db.InitDB;

/**
 * Servlet implementation class AddCar
 */
@WebServlet("/AddCar")
public class AddCar extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private PreparedStatement statement;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddCar() {
		super();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
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

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			InitDB.closeConnection();
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

			finalimage = buffer.toString() + "_" + r + domainName;

			path = "home/atul/Projects/1_ServerData/carImages/";
			savedFile = new File(path + finalimage);
			item.write(savedFile);

			if (savedFile.exists())
				processFormData(formData, path + finalimage, request, response);

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

	}

	private void processFormData(HashMap<String, String> formData, String imagePath, HttpServletRequest request,
			HttpServletResponse response) throws SQLException, IOException {
		System.out.println("Processing form");
		String name = formData.get("inputName");
		String numberPlate = formData.get("inputPlate");
		String userId = null;
		String image = imagePath;

		ServletContext sc = request.getServletContext();
		Cookie[] cookies = request.getCookies();
		Cookie cookie = null;

		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				cookie = cookies[i];
				if (cookie.getName().equals("userId")) {
					userId = cookie.getValue();
				}
			}
		}

		if (image != null && userId != null) {
			statement = InitDB.getConnection()
					.prepareStatement("INSERT INTO car(name, numberPlate, image, userId) values (?, ?, ?, ?)");

			statement.setString(1, name);
			statement.setString(2, numberPlate);
			statement.setString(3, image);
			statement.setString(4, userId);

			int action = statement.executeUpdate();
			if (action > 0) {
				response.sendRedirect("dashboard.jsp");
			} else {
				String htmlMessage = "<p class='text-center text-danger'>*** Some problem occurred ***</p>";
				sc.setAttribute("addcars", htmlMessage);

				response.sendRedirect("addcar.jsp");
			}
		}

	}

}
