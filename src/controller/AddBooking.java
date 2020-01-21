package controller;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.InitDB;

/**
 * Servlet implementation class AddBooking
 */
@WebServlet("/AddBooking")
public class AddBooking extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private PreparedStatement statement;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddBooking() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String parkingId = request.getParameter("parkingId");
		String carId = request.getParameter("carId");
		String inputHour = request.getParameter("inputHour");
		String dateAdded = java.time.LocalDate.now().toString();
		String timeAdded = java.time.LocalTime.now().toString();
		String totalPrice = null;

		String userId = null;
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

		try {
			totalPrice = calculatePrice(parkingId, inputHour);

			// add booking
			if (userId != null) {
				statement = InitDB.getConnection().prepareStatement(
						"INSERT INTO booking(parkingId, userId, carId, datePlaced, timePlaced, price, hour) values (?, ?, ?, ?, ?, ?, ?)");

				statement.setString(1, parkingId);
				statement.setString(2, userId);
				statement.setString(3, carId);
				statement.setString(4, dateAdded);
				statement.setString(5, timeAdded);
				statement.setString(6, totalPrice);
				statement.setString(7, inputHour);

				int action = statement.executeUpdate();
				if (action > 0) {
					response.sendRedirect("currentparking.jsp");
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			InitDB.closeConnection();
		}
	}

	private String calculatePrice(String parkingId, String inputHour) throws SQLException {
		double totalPrice = 0;
		String fare = null;

		PreparedStatement statement = InitDB.getConnection()
				.prepareStatement("SELECT fare from parking where parkingId = ?");
		statement.setString(1, parkingId);

		ResultSet rs = statement.executeQuery();
		if (rs.next()) {
			fare = rs.getString("fare");
		}

		if (fare != null)
			totalPrice = Double.parseDouble(fare) * Double.parseDouble(inputHour);

		return String.valueOf(totalPrice);
	}

}
