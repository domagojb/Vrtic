package hr.fer.zemris.opp.servlets.userfunctions;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import hr.fer.zemris.opp.dao.DAOProvider;
import hr.fer.zemris.opp.model.records.EducatorActivity;
import hr.fer.zemris.opp.model.users.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Allows the accountant and admin view the {@link EducatorActivity} logs for educators.
 * @author domagoj
 *
 */
@WebServlet("/userpanel/veiwactivitylogs")
public class ViewEducatorActivityLogs extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		boolean auth = checkAuthorization(req, resp);
		
		if (!auth) {
			return;
		}
		
		List<User> users = DAOProvider.getDAO().getAllUsers();
		List<User> educators = new ArrayList<User>();
		
		for (User u : users) {
			if (u.getType().equals("edu")) {
				educators.add(u);
			}
		}
		
		req.setAttribute("educators", educators);
		
		String sUID = req.getParameter("user");
		String sLID = req.getParameter("log");
		
		// a user nor form has not been selected
		if (sUID == null && sLID == null) {
			// set the logs for the first user
			if (educators.isEmpty() == false) {
				final int ZERO = 0;
				req.setAttribute("logs", educators.get(ZERO).getActivityLog());
			}
			req.getRequestDispatcher("/WEB-INF/pages/viewactivitylogs.jsp").forward(req, resp);
			return;
		}
		
		// log was chosen
		if (sUID == null) {
			long lid;
			try {
				lid = Long.valueOf(sLID);
			} catch (NumberFormatException e) {
				req.setAttribute("userErrorMessage", "Interna pogreška -222");
				req.getRequestDispatcher("/WEB-INF/pages/Error.jsp").forward(req, resp);
				return;
			}
			EducatorActivity log = DAOProvider.getDAO().getEducatorActivity(lid);
			req.setAttribute("selected_user", log.getEducator());
			req.setAttribute("logs", log.getEducator().getActivityLog());
			req.setAttribute("log", log);			
		} else { // user was chosen
		
			long uid;
			User u = null;
			try {
				uid = Long.valueOf(sUID);
				u = DAOProvider.getDAO().getUser(uid);
			} catch (NumberFormatException e) {
				req.setAttribute("userErrorMessage", "Interna pogreška -221");
				req.getRequestDispatcher("/WEB-INF/pages/Error.jsp").forward(req, resp);
				return;
			}
			req.setAttribute("selected_user", u);
			req.setAttribute("logs", u.getActivityLog());
		}
		
		req.getRequestDispatcher("/WEB-INF/pages/viewactivitylogs.jsp").forward(req, resp);
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
