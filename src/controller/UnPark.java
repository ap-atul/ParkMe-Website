package controller;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.InitDB;

/**
 * Servlet implementation class UnPark
 */
@WebServlet("/UnPark")
public class UnPark extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private PreparedStatement statement;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UnPark() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String carId = request.getParameter("carId");
		
		try {
			statement = InitDB.getConnection().prepareStatement("UPDATE booking SET completion = 1 WHERE carId = ?");
		
			statement.setString(1, carId);
			
			int action = statement.executeUpdate();
			if(action > 0) {
				response.sendRedirect("currentparking.jsp");
			} else {
				response.sendRedirect("currentparking.jsp");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
