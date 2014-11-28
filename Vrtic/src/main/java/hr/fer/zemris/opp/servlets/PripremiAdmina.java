package hr.fer.zemris.opp.servlets;

import hr.fer.zemris.opp.dao.DAOProvider;
import hr.fer.zemris.opp.model.users.User;
import hr.fer.zemris.opp.password.PasswordHasher;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * This servlet set's up the admin account.
 * 
 * Once run this script should be deleted from the
 * application and the application must be reinstaled.
 * 
 * @author domagoj
 *
 */
@WebServlet("/initadmin")
public class PripremiAdmina extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		User admin = new User();
		admin.setFirstName("admin");
		admin.setLastName("adminic");
		admin.setNick("admin");
		admin.setPasswordHash(PasswordHasher.getHexHash("passwd"));
		admin.setType("adm");
		DAOProvider.getDAO().insertUser(admin);
		
		resp.sendRedirect(req.getServletContext().getContextPath() + "/index.jsp");
	}
}
