package controller;

import java.io.File;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
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

import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.*;

import db.InitDB;

/**
 * Servlet implementation class AddParking
 */
@WebServlet("/AddParking")
public class AddParking extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private PreparedStatement statement;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddParking() {
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
			HttpServletResponse response) throws IOException, SQLException {

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

			path = "home/atul/Projects/1_ServerData/parkingImages/";
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
		String ownerName = formData.get("inputName");
		String contact = formData.get("inputContact");
		String spots = formData.get("inputSpots");
		String fare = formData.get("inputFare");
		String placeName = formData.get("inputPlaceName");
		String address = formData.get("inputAddress") + formData.get("inputAddress2");
		String city = formData.get("inputCity");
		String state = formData.get("inputState");
		String zip = formData.get("inputZip");
		String image = imagePath;
		String cityId = "";

		String userId = null;
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

		// adding city entry
		if (userId != null && image != null) {
			statement = InitDB.getConnection().prepareStatement(
					"INSERT INTO city(city, state, pincode, address) values (?, ?, ?, ?)",
					Statement.RETURN_GENERATED_KEYS);

			statement.setString(1, city);
			statement.setString(2, state);
			statement.setString(3, zip);
			statement.setString(4, address);

			int action = statement.executeUpdate();
			ResultSet rs = statement.getGeneratedKeys();
			if (action > 0 && rs.next()) {
				cityId = String.valueOf(rs.getInt(1));

				statement = InitDB.getConnection().prepareStatement(
						"INSERT INTO parking(placeName, ownerName, userId, cityId, spots, fare, contact, image) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");

				statement.setString(1, placeName);
				statement.setString(2, ownerName);
				statement.setString(3, userId);
				statement.setString(4, cityId);
				statement.setString(5, spots);
				statement.setString(6, fare);
				statement.setString(7, contact);
				statement.setString(8, image);

				action = statement.executeUpdate();

				if (action > 0) {

					System.out.println("Parking INSERTED");
					String htmlMessage = "<p class='text-center text-danger'>*** Your Parking Space is registered ***</p>";
					sc.setAttribute("rent", htmlMessage);

					response.sendRedirect("myparking.jsp");
				} else {
					String htmlMessage = "<p class='text-center text-danger'>*** Some problem occurred ***</p>";
					sc.setAttribute("rent", htmlMessage);

					response.sendRedirect("rentmyspace.jsp");
				}
			} else {
				System.out.println("Error occured");
			}
		} else {
			String htmlMessage = "<p class='text-center text-danger'>*** Some problem occurred ***</p>";
			sc.setAttribute("rent", htmlMessage);

			response.sendRedirect("rentmyspace.jsp");
		}

	}

}
