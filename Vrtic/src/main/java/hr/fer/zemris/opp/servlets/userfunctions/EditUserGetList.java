package hr.fer.zemris.opp.servlets.userfunctions;

import hr.fer.zemris.opp.dao.DAOProvider;
import hr.fer.zemris.opp.model.users.User;
import hr.fer.zemris.opp.servlets.forms.AddUserForm;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Retrieves a list of all {@link User}s and maps them into
 * an attribute.
 * 
 * Calls "edituserlist.jsp"
 * 
 * @author domagoj
 *
 */
@WebServlet("/userpanel/edituser")
public class EditUserGetList extends HttpServlet {
	
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
		
		// playing with the main admin is not allowed
		users.remove(0);
		
		req.setAttribute("users", users);
		
		req.getRequestDispatcher("/WEB-INF/pages/edituserlist.jsp").forward(req, resp);
	}
	
	/**
	 * Maps the id of the returned user into an {@link Integer}
	 * and puts into attribute "user" for the editor servlet.
	 * 
	 * In the attribute "option" tells the jsp either to create a
	 * form for editing the password or user information.
	 */
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		String sid = req.getParameter("user");
		
		Integer id = null;
		try {
			id = Integer.valueOf(sid);
		} catch (NumberFormatException e) {
			req.setAttribute("userErrorMessage", "Interna greska susava -92");
			req.getRequestDispatcher("/WEB-INF/pages/Error.jsp").forward(req, resp);
			return;
		}
		
		User u = DAOProvider.getDAO().getUser(id);
		
		AddUserForm form = new AddUserForm();
		form.fillFormFromUser(u);
		
		req.setAttribute("id", sid);
		req.setAttribute("form", form);
		req.setAttribute("option", req.getParameter("method"));
		
		req.getRequestDispatcher("/WEB-INF/pages/edituser.jsp").forward(req, resp);
	}
}
