package hr.fer.zemris.opp.servlets.userfunctions;

import hr.fer.zemris.opp.dao.DAOProvider;
import hr.fer.zemris.opp.model.Group;
import hr.fer.zemris.opp.model.records.SignUpRecord;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/userpanel/opensignup")
public class OpenSignUp extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		boolean auth = checkAuthorization(req, resp);
		
		if (!auth) {
			return;
		}
		
		List<SignUpRecord> records = DAOProvider.getDAO().getSignUpRecords();

		if (records != null && records.size() > 0) {
			final int FIRST_ELEMENT = 0;
			SignUpRecord record = records.get(FIRST_ELEMENT);
			if (record.isSignUpOpen()) {
				req.setAttribute("msg", "Prijave su u tijeku");
				req.getRequestDispatcher("/WEB-INF/pages/opensignup.jsp").forward(req, resp);
				return;
			}
		}
		
		List<Group> groups = DAOProvider.getDAO().getAllGroups();
		List<Group> openGroups = new ArrayList<Group>();
		List<Group> closedGroups = new ArrayList<Group>();
		
		for (Group group : groups) {
			if (group.hasRoom()) {
				openGroups.add(group);
			} else {
				closedGroups.add(group);
			}
		}
		
		req.setAttribute("openGroups", openGroups);
		req.setAttribute("closedGroups", closedGroups);
		
		String method = req.getParameter("method");
		if (method != null && method.equals("Otvori upis")) {
			if (records != null && records.size() > 0) {
				final int FIRST_ELEMENT = 0;
				SignUpRecord record = records.get(FIRST_ELEMENT);
				record.setSignUpOpen(true); // open the sign up
			} else {
				SignUpRecord record = new SignUpRecord();
				record.setSignUpOpen(true);
				DAOProvider.getDAO().insertSignUpRecord(record);
			}
			resp.sendRedirect(req.getServletContext().getContextPath() + "/userpanel");
			return;
		}
		
		req.getRequestDispatcher("/WEB-INF/pages/opensignup.jsp").forward(req, resp);
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
}
