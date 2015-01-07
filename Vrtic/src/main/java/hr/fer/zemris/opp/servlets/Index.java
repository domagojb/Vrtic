package hr.fer.zemris.opp.servlets;

import hr.fer.zemris.opp.dao.DAOProvider;
import hr.fer.zemris.opp.dao.jpa.JPADAOImpl;
import hr.fer.zemris.opp.model.Child;
import hr.fer.zemris.opp.model.Group;
import hr.fer.zemris.opp.model.Parent;
import hr.fer.zemris.opp.model.records.SignUpRecord;
import hr.fer.zemris.opp.model.users.User;
import hr.fer.zemris.opp.password.PasswordHasher;
import hr.fer.zemris.opp.servlets.forms.AddChildForm;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Starting servlet mapped to index.jsp, i.e. the loading page.
 * 
 * @author Domagoj Boros
 *
 */
@WebServlet("/index.jsp")
public class Index extends HttpServlet{

	/**
	 * Nemam pojma kaj je ovo, al bar ne baca warning.
	 */
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		List<SignUpRecord> records = DAOProvider.getDAO().getSignUpRecords();
		if (records == null || records.size() == 0) {
			req.setAttribute("signUpOpen", false);
		} else {
			req.setAttribute("signUpOpen", records.get(0).isSignUpOpen());
		}
		
		List<Group> groups = DAOProvider.getDAO().getAllGroups();
		
		req.setAttribute("groups", groups);
		
		AddChildForm form = new AddChildForm();
		req.setAttribute("form", form);

		req.getRequestDispatcher("/WEB-INF/pages/index.jsp").forward(req, resp);
	}
	
	/**
	 * The post method on this served will be called when someone attepmts a login or
	 * wants to sign up a child when the sign ups are open.
	 * 
	 * The login info must be in the parameters "username" and "password".
	 * If there is an error (the user doesn't exist, wrong password) an error message
	 * will be set in the parameter "loginError". If there is no error then loginError
	 * will be <code>null</code>.
	 * 
	 */
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		String method = req.getParameter("method");
		if (method != null && method.equals("Log in")) {
		
			req.setAttribute("loginError", null);
			
			String username = req.getParameter("username");
			if(username == null) {
				req.setAttribute("loginError", "Korisničko ime ili zaporka je progrešna.");
				doGet(req, resp);
				return;
			}
			
			String password = req.getParameter("password");
			if(password == null) {
				req.setAttribute("loginError", "Korisničko ime ili zaporka je progrešna.");
				doGet(req, resp);
				return;
			}
			
			User user = checkLogin(username, password);
			
			if(user == null) {
				req.setAttribute("loginError", "Korisničko ime ili zaporka je progrešna");
				doGet(req, resp);
				return;
			}
			
			req.getSession().setAttribute("current.user", user);
			req.getSession().setAttribute("current.user.id", user.getId());
			req.getSession().setAttribute("current.user.fn", user.getFirstName());
			req.getSession().setAttribute("current.user.ln", user.getLastName());
			req.getSession().setAttribute("current.user.nick", user.getNick());
			req.getSession().setAttribute("current.user.t", user.getType());
			
			doGet(req, resp);
			return;
		} else if (method != null && method.equals("Upis")) {
		
			AddChildForm form = new AddChildForm();
			form.fillFromHttpRequest(req);
			form.validate();
			
			if (form.hasErrors()) {
				List<SignUpRecord> records = DAOProvider.getDAO().getSignUpRecords();
				if (records == null || records.size() == 0) {
					req.setAttribute("signUpOpen", false);
				} else {
					req.setAttribute("signUpOpen", records.get(0).isSignUpOpen());
				}
				
				List<Group> groups = DAOProvider.getDAO().getAllGroups();
				
				req.setAttribute("groups", groups);
				req.setAttribute("form", form);
				req.getRequestDispatcher("/WEB-INF/pages/index.jsp").forward(req, resp);
				return;
			}
			
			Parent p = form.getParentFromForm();
			Child c = form.getChildFromForm();
			
			DAOProvider.getDAO().insertParent(p);
			
			p.addChild(c);
			DAOProvider.getDAO().insertChild(c);
			
			req.setAttribute("confirmationMsg", "Prijava uspješno poslana");
			resp.sendRedirect(req.getServletContext().getContextPath());
			return;
		
		}
		
		doGet(req, resp);
	}

	/**
	 * Check if the login is right. If it is return
	 * the {@link BlogUser} that should be loged in. 
	 * 
	 * @param username of the user
	 * @param password of the user
	 * @return {@link BlogUser} with information of the loged in user or <code>null</code> if
	 * there is no such user, i.e. the login information is bad
	 */
	private User checkLogin(String username, String password) {
		
		User user = DAOProvider.getDAO().getUser(username, PasswordHasher.getHexHash(password));
		return user;
	}
}
