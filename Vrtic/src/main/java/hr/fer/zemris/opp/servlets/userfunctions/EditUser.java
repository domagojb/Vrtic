package hr.fer.zemris.opp.servlets.userfunctions;

import hr.fer.zemris.opp.dao.DAOProvider;
import hr.fer.zemris.opp.model.users.User;
import hr.fer.zemris.opp.password.PasswordHasher;
import hr.fer.zemris.opp.servlets.forms.AddUserForm;
import hr.fer.zemris.opp.servlets.forms.EditUserForm;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/userpanel/edituser/editor")
public class EditUser extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
			String option = req.getParameter("method");
			EditUserForm form = new EditUserForm();
			if (option.equals("Izmijeni podatke")) {
				form.fillFromHttpRequest(req, EditUserForm.Option.INFO);
				form.validate();
				
				if(form.hasErrors()) {
					req.setAttribute("form", form);
					req.setAttribute("id", req.getParameter("id"));
					req.setAttribute("option", "Izmijeni podatke");
					req.getRequestDispatcher("/WEB-INF/pages/edituser.jsp").forward(req, resp);
					return;
				}
				
				Long id = Long.valueOf(req.getParameter("id"));
				User u = DAOProvider.getDAO().getUser(id);
				u.setFirstName(form.getFirstName());
				u.setLastName(form.getLastName());
				u.setNick(form.getNick());
				u.setType(form.getType());
				resp.sendRedirect(req.getServletContext().getContextPath() + "/userpanel");
				return;
			} 
			
			if (option.equals("Izmijeni lozinku")) {
				form.fillFromHttpRequest(req, EditUserForm.Option.PASSWORD);
				form.validate();
				
				if(form.hasErrors()) {
					req.setAttribute("form", form);
					req.setAttribute("id", req.getParameter("id"));
					req.setAttribute("option", "Izmijeni lozinku");
					req.getRequestDispatcher("/WEB-INF/pages/edituser.jsp").forward(req, resp);
					return;
				}
				
				Long id = Long.valueOf(req.getParameter("id"));
				User u = DAOProvider.getDAO().getUser(id);
				u.setPasswordHash(PasswordHasher.getHexHash(form.getPassword()));
				resp.sendRedirect(req.getServletContext().getContextPath() + "/userpanel");
				return;
			} 
			
			req.setAttribute("userErrorMessage", "Interna pogreška -101");
			req.getRequestDispatcher("/WEB-INF/pages/Error.jsp").forward(req, resp);
			return;
	}
}
