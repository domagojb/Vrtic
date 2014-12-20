package hr.fer.zemris.opp.servlets.userfunctions;

import hr.fer.zemris.opp.dao.DAOProvider;
import hr.fer.zemris.opp.model.Group;
import hr.fer.zemris.opp.model.Workplace;
import hr.fer.zemris.opp.model.users.User;
import hr.fer.zemris.opp.servlets.forms.AddGroupForm;
import hr.fer.zemris.opp.servlets.forms.AddWorkplaceForm;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet used for adding a {@link Group} to a {@link Workplace}.
 * @author domagoj
 *
 */
@WebServlet("/userpanel/addgroup")
public class AddGroup extends HttpServlet {

	/**
	 * Retrieves the list off {@link Workplace}s and maps them to the attribute "workplaces".
	 * Retrieves the list off all educators that don't work in a group and maps it to the attribute "educators".
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
		
		List<Workplace> workplaces = DAOProvider.getDAO().getAllWorkplaces();
		req.setAttribute("workplaces", workplaces);
		
		List<User> users = DAOProvider.getDAO().getAllUsers();
		List<User> educators = new ArrayList<User>();
		for(User u : users) {
			if (u.getType().equals("edu") && u.getGroup() == null) {
				educators.add(u);
			}
		}
		
		req.setAttribute("educators", educators);
		
		req.getRequestDispatcher("/WEB-INF/pages/addgroup.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		AddGroupForm form = new AddGroupForm();
		form.fillFromHttpRequest(req);
		form.validate();
		
		if(form.hasErrors()) {
			req.setAttribute("form", form);
			
			List<Workplace> workplaces = DAOProvider.getDAO().getAllWorkplaces();
			req.setAttribute("workplaces", workplaces);
			
			List<User> users = DAOProvider.getDAO().getAllUsers();
			List<User> educators = new ArrayList<User>();
			for(User u : users) {
				if (u.getType().equals("edu") && u.getGroup() == null) {
					educators.add(u);
				}
			}
			
			req.setAttribute("educators", educators);
			
			req.getRequestDispatcher("/WEB-INF/pages/addgroup.jsp").forward(req, resp);
			return;
		}
		
		Group g = form.getGroupFromForm();
		DAOProvider.getDAO().insertGroup(g);
		
		// get the id of the educators selected for the group
		String[] sUIDs = req.getParameterValues("educators");
		
		// add the groups to the educators
		for (String sUID : sUIDs) {
			Long uid = Long.valueOf(sUID);
			User u = DAOProvider.getDAO().getUser(uid);
			u.setGroup(g);
		}
		
		resp.sendRedirect(req.getServletContext().getContextPath() + "/userpanel");
	}
	
}
