package hr.fer.zemris.opp.servlets.userfunctions;

import hr.fer.zemris.opp.dao.DAOProvider;
import hr.fer.zemris.opp.model.Child;
import hr.fer.zemris.opp.model.Group;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet gives the admin the option to remove a child from a group
 * and system altogether.
 * 
 * @author domagoj
 *
 */
@WebServlet("/userpanel/removechild")
public class RemoveChild extends HttpServlet {
	
	/**
	 * Allows the admin to select the group from which to extract the list
	 * of children and then select a child and remove it.
	 */
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		boolean auth = checkAuthorization(req, resp);
		
		if (!auth) {
			return;
		}
		
		List<Group> groups = DAOProvider.getDAO().getAllGroups();
		req.setAttribute("groups", groups);
		
		// if a group hasn't been selected
		String sGID = req.getParameter("group");
		if (sGID == null) {
			req.getRequestDispatcher("/WEB-INF/pages/removechild.jsp").forward(req, resp);
			return;
		}
		
		long gid = 0;
		try {
			gid = Long.valueOf(sGID);
		} catch (NumberFormatException e) {
			req.getRequestDispatcher("/WEB-INF/pages/removechild.jsp").forward(req, resp);
			return;
		}
		
		List<Child> children = DAOProvider.getDAO().getChildrenInGroup(gid);
		if (children == null) {
			children = new ArrayList<Child>();
		}
		req.setAttribute("children", children);
		
		req.getRequestDispatcher("/WEB-INF/pages/removechild.jsp").forward(req, resp);
	}

	/**
	 * Checks whether the user is authorized to view this page. 
	 * If he isn't set's the error and calls the error page.
	 * 
	 * Returns <code>true</code> if the user is allowed to continue,
	 * <code>false</code> else.
	 * 
	 * @param resp inherited from {@link #doGet(HttpServletRequest, HttpServletResponse)}
	 * @param req inherited from {@link #doGet(HttpServletRequest, HttpServletResponse)}
	 * @throws IOException 
	 * @throws ServletException 
	 */
	private boolean checkAuthorization(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String type = (String) req.getSession().getAttribute("current.user.t");
		
		if (type == null) {
			req.setAttribute("userErrorMessage", "Neautoriziran pristup");
			req.getRequestDispatcher("/WEB-INF/pages/Error.jsp").forward(req, resp);
			return false;
		}
		
		if (!type.equals("adm")) {
			req.setAttribute("userErrorMessage", "Neautoriziran pristup");
			req.getRequestDispatcher("/WEB-INF/pages/Error.jsp").forward(req, resp);
			return false;
		}	
		
		return true;
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String sCID = req.getParameter("child");
		long cid = Long.valueOf(sCID);
		
		DAOProvider.getDAO().removeChild(cid);
		
		resp.sendRedirect(req.getServletContext().getContextPath() + "/userpanel");
	}
}
