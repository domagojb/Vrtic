package hr.fer.zemris.opp.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * The servlet logs out the current user.
 * 
 * @author Domagoj Boros
 *
 */
@WebServlet("/logout")
public class Logout extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		req.getSession().invalidate();			
		resp.sendRedirect(req.getServletContext().getContextPath() + "/index.jsp");
	}
}
