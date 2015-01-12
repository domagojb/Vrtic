package hr.fer.zemris.opp.servlets.userfunctions;

import hr.fer.zemris.opp.dao.DAOProvider;
import hr.fer.zemris.opp.dao.jpa.JPAEMProvider;
import hr.fer.zemris.opp.model.Child;
import hr.fer.zemris.opp.model.Group;
import hr.fer.zemris.opp.model.Workplace;
import hr.fer.zemris.opp.model.records.ChildRecord;
import hr.fer.zemris.opp.model.users.User;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/userpanel/removeworkplace")
public class RemoveWorkplace extends HttpServlet {

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
				
		List<Workplace> workplaces = DAOProvider.getDAO().getAllWorkplaces();
		
		req.setAttribute("workplaces", workplaces);
		
		req.getRequestDispatcher("/WEB-INF/pages/removeworkplace.jsp").forward(req, resp);
	}
	
	/**
	 * Removes the selected users in the form.
	 */
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String sWID = req.getParameter("workplace");
		
		Long wid = Long.valueOf(sWID);
		
		Workplace w = DAOProvider.getDAO().getWorkplace(wid);
		
		for (Group g : w.getGroups()) {
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
			
			//g.getWorkplace().getGroups().remove(g);
			
			JPAEMProvider.getEntityManager().remove(g);
		}
				
		JPAEMProvider.getEntityManager().remove(w);
		
		resp.sendRedirect(req.getServletContext().getContextPath() + "/userpanel");
	}
}
