package controller;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.InitDB;

import java.sql.*;

/**
 * Servlet implementation class Contact
 */
@WebServlet(urlPatterns = "/Contact")
public class Contact extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private PreparedStatement statement;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Contact() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String fname = request.getParameter("fname");
		String lname = request.getParameter("lname");
		String email = request.getParameter("email");
		String message = request.getParameter("message");

		try {
			statement = InitDB.getConnection().prepareStatement(
					"INSERT INTO contact(firstName, lastName, email, message, dateAdded) " + "VALUES(?, ?, ?, ?, ?)");
			statement.setString(1, fname);
			statement.setString(2, lname);
			statement.setString(3, email);
			statement.setString(4, message);
			statement.setDate(5, new Date(0));

			int action = statement.executeUpdate();
			if (action > 0) {
				String htmlMessage = "<p>*** Your message is submitted. ***</p>";
				ServletContext sc = request.getServletContext();
				if (sc.getAttribute("contact") == null) {
					sc.setAttribute("contact", htmlMessage);
				} else {
					String currentMessages = (String) sc.getAttribute("contact");
					sc.setAttribute("contact", htmlMessage + currentMessages);
				}
				response.sendRedirect("index.jsp#contact");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			InitDB.closeConnection();
		}
	}

}
