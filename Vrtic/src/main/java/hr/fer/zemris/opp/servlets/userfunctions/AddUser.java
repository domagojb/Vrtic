package hr.fer.zemris.opp.servlets.userfunctions;

import hr.fer.zemris.opp.dao.DAOProvider;
import hr.fer.zemris.opp.model.users.User;
import hr.fer.zemris.opp.servlets.forms.AddUserForm;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/userpanel/adduser")
public class AddUser extends HttpServlet {

	/**
	 * Prepares an empty registration form.
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
		
		AddUserForm form = new AddUserForm();
		req.setAttribute("form", form);
		
		req.getRequestDispatcher("/WEB-INF/pages/adduser.jsp").forward(req, resp);
	}
	
	/**
	 * Called when the user attempts to register. The form is validated and checked. If
	 * it passes the validation the user will be registered, else he will be prompted with
	 * errors and his form.
	 */
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		AddUserForm form = new AddUserForm();
		form.fillFromHttpRequest(req);
		form.validate();
		
		if(form.hasErrors()) {
			req.setAttribute("form", form);
			req.getRequestDispatcher("/WEB-INF/pages/adduser.jsp").forward(req, resp);
			return;
		}
		
		User user = form.getUserFromForm();
		DAOProvider.getDAO().insertUser(user);
		resp.sendRedirect(req.getServletContext().getContextPath() + "/userpanel");
	}
}
