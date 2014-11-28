package hr.fer.zemris.opp.servlets.userfunctions;

import hr.fer.zemris.opp.dao.DAOProvider;
import hr.fer.zemris.opp.model.users.User;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Presents the admin with the list of all users.
 * 
 * He can choose the users he wants to delete.
 * @author domagoj
 *
 */
@WebServlet("/userpanel/removeuser")
public class RemoveUser extends HttpServlet {

	/**
	 * Prepares a list of all users, maps them to the attribute "users".
	 */
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		String type = (String) req.getSession().getAttribute("current.user.t");
		
		if (type == null) {
			req.setAttribute("userErrorMessage", "Neautoriziran pristup");
			req.getRequestDispatcher("/WEB-INF/pages/Error.jsp").forward(req, resp);
			return;
		}
		
		if (!type.equals("adm")) {
			req.setAttribute("userErrorMessage", "Neautoriziran pristup");
			req.getRequestDispatcher("/WEB-INF/pages/Error.jsp").forward(req, resp);
			return;
		}
		
		
		List<User> users = DAOProvider.getDAO().getAllUsers();
		
		// remove the admin user
		users.remove(0);
		
		req.setAttribute("users", users);
		
		req.getRequestDispatcher("/WEB-INF/pages/removeuser.jsp").forward(req, resp);
	}
	
	/**
	 * Removes the selected users in the form.
	 */
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String[] users = req.getParameterValues("users");
		
		if (users != null) {
			for(String user : users) {
				DAOProvider.getDAO().removeUser(user);
			}
		}
		
		resp.sendRedirect(req.getServletContext().getContextPath() + "/userpanel");
	}
}
