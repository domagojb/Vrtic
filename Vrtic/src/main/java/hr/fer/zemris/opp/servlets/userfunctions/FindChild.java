package hr.fer.zemris.opp.servlets.userfunctions;

import hr.fer.zemris.opp.dao.DAO;
import hr.fer.zemris.opp.dao.DAOProvider;
import hr.fer.zemris.opp.model.Child;
import hr.fer.zemris.opp.model.Group;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Allows the admin or accountant to search for a child whether
 * by search engine or by group.
 * 
 * @author domagoj
 *
 */
@WebServlet("/userpanel/findchild")
public class FindChild extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		boolean auth = checkAuthorization(req, resp);
		
		if (!auth) {
			return;
		}
		
		List<Group> groups = DAOProvider.getDAO().getAllGroups();
		req.setAttribute("groups", groups);
		
		String method = req.getParameter("method");
		
		// no option was chosen
		if (method == null) {
			req.setAttribute("firstName", "");
			req.setAttribute("lastName", "");
			req.setAttribute("oib", "");
			req.getRequestDispatcher("/WEB-INF/pages/findchild.jsp").forward(req, resp);
			return;
		}
		
		if (method.equals("Pretrazi")) {
			String firstName = req.getParameter("firstName");
			String lastName = req.getParameter("lastName");
			String oib = req.getParameter("oib");
			
			req.setAttribute("firstName", firstName);
			req.setAttribute("lastName", lastName);
			req.setAttribute("oib", oib);
			
			System.out.println(oib.length());
			
			List<Child> children = DAOProvider.getDAO().getUsersLikeFields(firstName, lastName, oib);
			req.setAttribute("children", children);
			req.getRequestDispatcher("/WEB-INF/pages/findchild.jsp").forward(req, resp);
			return;
		}
		
		String sGID = req.getParameter("group");
		
		long gid;
		try {
			gid = Long.valueOf(sGID);
		} catch (NumberFormatException e) {
			req.setAttribute("userErrorMessage", "Interna pogreška -11");
			req.getRequestDispatcher("/WEB-INF/pages/Error.jsp").forward(req, resp);
			return;
		}
		
		Group g = DAOProvider.getDAO().getGroup(gid);
		List<Child> children = g.getChildren();
		req.setAttribute("children", children);
		req.getRequestDispatcher("/WEB-INF/pages/findchild.jsp").forward(req, resp);
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
		
		if (!type.equals("adm") && !type.equals("acc")) {
			req.setAttribute("userErrorMessage", "Neautoriziran pristup");
			req.getRequestDispatcher("/WEB-INF/pages/Error.jsp").forward(req, resp);
			return false;
		}	
		
		return true;
	}
}
