package controller;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.InitDB;

/**
 * Servlet implementation class Search
 */
@WebServlet("/Search")
public class Search extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private PreparedStatement statement;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Search() {
        super();
        
    }
    
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String pincode = request.getParameter("inputPincode");
		String city = request.getParameter("inputCity");
		String lat = request.getParameter("lat");
		String lng = request.getParameter("lng");
		
		ServletContext sc = request.getServletContext();
		List<String> cityId = new ArrayList<String>();
		
		try {
			if(lat != "" && lng != "") {
				statement = InitDB.getConnection().prepareStatement("SELECT cityId, (6371 *  acos(cos(radians(?)) * cos(radians(lat)) * cos(radians(lng) -  radians(?)) + sin(radians(?)) *  sin(radians(lat ))) ) AS distance FROM city HAVING distance < 45 ORDER BY distance LIMIT 0, 20");
				
				statement.setString(1, lat);
				statement.setString(2, lng);
				statement.setString(3, lat);
			} else {
				statement = InitDB.getConnection().prepareStatement("SELECT cityId FROM city WHERE city LIKE '%'?'%' OR pincode = ?");
				
				statement.setString(1, city);
				statement.setString(2, pincode);
			}
			
			ResultSet rs = statement.executeQuery();
			while(rs.next()) {
				cityId.add(rs.getString("cityId"));
			}
			
			if(cityId.size() > 0) {
				String sql = "SELECT * FROM parking WHERE cityId =";
				
				for(int i = 0; i < cityId.size() - 1; i++) {
					sql = sql + cityId.get(i) + " OR cityId = ";
				}
				sql = sql + cityId.get(cityId.size() - 1);
				
				statement = InitDB.getConnection().prepareStatement(sql);
				rs = statement.executeQuery();
				
				sc.setAttribute("parking", rs);
				response.sendRedirect("parkmyvehicle.jsp");
			} else {
				response.sendRedirect("parkmyvehicle.jsp");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
