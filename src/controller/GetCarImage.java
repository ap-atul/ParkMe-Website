package controller;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;

import db.InitDB;

/**
 * Servlet implementation class GetCarImage
 */
@WebServlet("/GetCarImage")
public class GetCarImage extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private PreparedStatement statement;
	private ResultSet resultSet;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GetCarImage() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String parkingId = request.getParameter("carId");
		String imagePath = null;
		InputStream is = null;

		try {
			statement = InitDB.getConnection().prepareStatement("SELECT image FROM car WHERE carId = ?");
			statement.setString(1, parkingId);

			resultSet = statement.executeQuery();
			if (resultSet.next()) {
				imagePath = resultSet.getString("image");
				is = new BufferedInputStream(new FileInputStream(imagePath));
				byte[] imageData = IOUtils.toByteArray(is);
				response.setContentType("image/jpeg");
				response.getOutputStream().write(imageData);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(is != null)
				is.close();
//			InitDB.closeConnection();
		}

	}

}
