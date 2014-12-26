package hr.fer.zemris.opp.servlets.userfunctions;

import hr.fer.zemris.opp.dao.DAOProvider;
import hr.fer.zemris.opp.model.Child;
import hr.fer.zemris.opp.model.Group;
import hr.fer.zemris.opp.model.records.ChildRecord;
import hr.fer.zemris.opp.model.users.FormException;
import hr.fer.zemris.opp.model.users.User;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Allows the user to enter the child records for the given group.
 * 
 * @author domagoj
 *
 */
@WebServlet("/userpanel/childrecord")
public class EnterChildRecord extends HttpServlet {

	/**
	 * The GET method expects a users id in the parameter "id" as it is 
	 * used to determine the group for which to create the record.
	 */
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		boolean auth = checkAuthorization(req, resp);
		
		if (!auth) {
			return;
		}
		
		String sUID = req.getParameter("id");
		
		Long uid;
		try {
			uid = Long.valueOf(sUID);
		} catch (NumberFormatException e) {
			req.setAttribute("userErrorMessage", "Interna pogreska -555");
			req.getRequestDispatcher("/WEB-INF/pages/Error.jsp").forward(req, resp);
			return;
		}
		
		User u = DAOProvider.getDAO().getUser(uid);
		
		if (u == null) {
			req.setAttribute("userErrorMessage", "Interna pogreska -556");
			req.getRequestDispatcher("/WEB-INF/pages/Error.jsp").forward(req, resp);
			return;
		}
		
		Group g = u.getGroup();
		req.setAttribute("group", g);
		
		if (g != null) { 
			List<Child> children = g.getChildren();
			req.setAttribute("children", children);
		}
		
		req.getRequestDispatcher("/WEB-INF/pages/childrecord.jsp").forward(req, resp);
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
		
		if (!type.equals("adm") && !type.equals("edu")) {
			req.setAttribute("userErrorMessage", "Neautoriziran pristup");
			req.getRequestDispatcher("/WEB-INF/pages/Error.jsp").forward(req, resp);
			return false;
		}	
		
		return true;
	}
	
	/**
	 * The current logged in user fills the record.
	 */
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		User u = (User) req.getSession().getAttribute("current.user");
		
		try {
			u.FillAttendanceRecord(req);
		} catch (FormException e) {
			req.setAttribute("userErrorMessage", e.getMessage());
			req.getRequestDispatcher("/WEB-INF/pages/Error.jsp").forward(req, resp);
			return;
		}
		
		resp.sendRedirect(req.getServletContext().getContextPath() + "/userpanel");
	}
}
