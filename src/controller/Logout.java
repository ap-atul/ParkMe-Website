package controller;


import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Logout
 */
@WebServlet("/Logout")
public class Logout extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Logout() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();		
		Cookie[] cookies = request.getCookies();
	    
		if( cookies != null ) {
			for (int i = 0; i < cookies.length; i++) {
	            Cookie cookie = cookies[i];

	            if((cookie.getName( )).compareTo("userId") == 0 ) {
	               cookie.setMaxAge(0);
	               response.addCookie(cookie);
	            }
	         }
	      }
		
		if(session.getAttribute("userId") != null) {
			session.invalidate();
			
		    response.sendRedirect("index.jsp");
		    return;
		}
	}

}
