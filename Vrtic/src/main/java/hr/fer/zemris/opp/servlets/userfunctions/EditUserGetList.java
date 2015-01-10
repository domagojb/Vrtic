package hr.fer.zemris.opp.servlets.userfunctions;

import hr.fer.zemris.opp.dao.DAO;
import hr.fer.zemris.opp.dao.DAOProvider;
import hr.fer.zemris.opp.model.Group;
import hr.fer.zemris.opp.model.users.User;
import hr.fer.zemris.opp.servlets.forms.AddUserForm;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Retrieves a list of all {@link User}s and maps them into
 * an attribute. Let's the admin choose to changes user info, password
 * or change the group of an educator.
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
		
		List<User> educators =  new ArrayList<User>();
		for (User u : users) {
			if (u.getType().equals("edu")) {
				educators.add(u);
			}
		}
		
		List<Group> groups = DAOProvider.getDAO().getAllGroups();

		
		req.setAttribute("users", users);
		req.setAttribute("educators", educators);
		req.setAttribute("groups", groups);
		
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
		String method = req.getParameter("method");
		// if the change group method was called
		if (method.equals("Izmijeni grupu")) {
			changeGroup(req, resp);
			resp.sendRedirect(req.getServletContext().getContextPath() + "/userpanel");
			return;
		}
		
		// else the other options were selected
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

	/**
	 * Changes the group for the selected user to the given group.
	 * 
	 * @param req
	 * @param resp
	 */
	private void changeGroup(HttpServletRequest req, HttpServletResponse resp) {
		String sUID = req.getParameter("educator");
		String sGID = req.getParameter("group");
		
		long uid = Long.valueOf(sUID);
		long gid = Long.valueOf(sGID);
		
		DAO dao = DAOProvider.getDAO();
		User u = dao.getUser(uid);
		Group g = dao.getGroup(gid);
		
		u.setGroup(g);
	}
}
