package hr.fer.zemris.opp.servlets.userfunctions;

import hr.fer.zemris.opp.dao.DAOProvider;
import hr.fer.zemris.opp.model.Child;
import hr.fer.zemris.opp.model.Group;
import hr.fer.zemris.opp.model.records.EducatorActivity;
import hr.fer.zemris.opp.model.users.FormException;
import hr.fer.zemris.opp.model.users.User;
import hr.fer.zemris.opp.servlets.forms.EnterEducatorActivityForm;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Allows the user to enter an {@link EducatorActivity} record.
 * @author domagoj
 *
 */
@WebServlet("/userpanel/educatoractivity")
public class EnterEducatorActivity extends HttpServlet {

	/**
	 * The GET method expects a users id in the parameter "id" as it is 
	 * used to determine the user for which to create the record.
	 * 
	 * The id is mapped into the attribute "uid".
	 */
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		boolean auth = checkAuthorization(req, resp);
		
		if (!auth) {
			return;
		}
		
		String sUID = req.getParameter("id");
		
		if (sUID == null) {
			req.setAttribute("userErrorMessage", "Interna pogreška -633");
			req.getRequestDispatcher("/WEB-INF/pages/Error.jsp").forward(req, resp);
			return;
		}
		
		req.setAttribute("uid", sUID);
		
		req.getRequestDispatcher("/WEB-INF/pages/educatoractivity.jsp").forward(req, resp);
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
		
		EnterEducatorActivityForm form = null;
		try {
			form = u.FillActivityLog(req);
		} catch (FormException e) {
			req.setAttribute("userErrorMessage", e.getMessage());
			req.getRequestDispatcher("/WEB-INF/pages/Error.jsp").forward(req, resp);
			return;
		}
		
		if (form.hasErrors()) {
			req.setAttribute("form", form);
			req.setAttribute("uid", req.getParameter("uid"));
			req.getRequestDispatcher("/WEB-INF/pages/educatoractivity.jsp").forward(req, resp);
		}
		
		resp.sendRedirect(req.getServletContext().getContextPath() + "/userpanel");
	}
}
