package hr.fer.zemris.opp.servlets.userfunctions;

import hr.fer.zemris.opp.dao.DAOProvider;
import hr.fer.zemris.opp.dao.jpa.JPAEMProvider;
import hr.fer.zemris.opp.model.Child;
import hr.fer.zemris.opp.model.Group;
import hr.fer.zemris.opp.model.records.ChildRecord;
import hr.fer.zemris.opp.model.users.User;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/userpanel/removegroup")
public class RemoveGroup extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

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
				
		List<Group> groups = DAOProvider.getDAO().getAllGroups();
		
		req.setAttribute("groups", groups);
		
		req.getRequestDispatcher("/WEB-INF/pages/removegroup.jsp").forward(req, resp);
	}
	
	/**
	 * Removes the selected users in the form.
	 */
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String sGID = req.getParameter("group");
		
		Long gid = Long.valueOf(sGID);
		
		Group g = DAOProvider.getDAO().getGroup(gid);
		List<User> users = g.getEducators();
		for (User user : users) {
			user.setGroup(null);
		}
		
		for (Child child : g.getChildren()) {
			child.setGroup(null);
		}
		
		for (Child child : g.getSignUpList()) {
			child.getSignUpGroups().remove(g);
		}
		
		for (ChildRecord r : g.getRecords()) {
			r.setGroup(null);
		}
		
		g.getWorkplace().getGroups().remove(g);
		
		//DAOProvider.getDAO().removeGroup(gid);
		JPAEMProvider.getEntityManager().remove(g);		

		
		resp.sendRedirect(req.getServletContext().getContextPath() + "/userpanel");
	}
}
