package hr.fer.zemris.opp.servlets.userfunctions;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Loads the apropriate panel for the logged in user.
 * 
 * If the admin is logged in prepares "adminpanel.jsp".
 * If the acc is logged in prepares "accpanel.jsp".
 * If the edu is logged in preparres "edupanel.jsp".
 * 
 * If no user is logged in or weird type is recognized
 * returns 401 Unauthorized.
 * 
 * @author domagoj
 *
 */
@WebServlet("/userpanel")
public class UserPanel extends HttpServlet {

	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		String type = (String) req.getSession().getAttribute("current.user.t");
		
		if (type == null) {
			req.setAttribute("userErrorMessage", "Neautoriziran pristup");
			req.getRequestDispatcher("/WEB-INF/pages/Error.jsp").forward(req, resp);
			return;
		}
		
		if (type.equals("adm")) {
			req.getRequestDispatcher("/WEB-INF/pages/adminpanel.jsp").forward(req, resp);
			return;
		}
		
		if (type.equals("edu")) {
			req.getRequestDispatcher("/WEB-INF/pages/edupanel.jsp").forward(req, resp);
			return;
		}
		
		if (type.equals("acc")) {
			req.getRequestDispatcher("/WEB-INF/pages/accpanel.jsp").forward(req, resp);
			return;
		}
		
		req.setAttribute("userErrorMessage", "Neautoriziran pristup");
		req.getRequestDispatcher("/WEB-INF/pages/Error.jsp").forward(req, resp);
	}
}
