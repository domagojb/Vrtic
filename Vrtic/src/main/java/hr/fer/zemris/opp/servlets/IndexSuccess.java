package hr.fer.zemris.opp.servlets;

import hr.fer.zemris.opp.dao.DAOProvider;
import hr.fer.zemris.opp.model.Group;
import hr.fer.zemris.opp.model.records.SignUpRecord;
import hr.fer.zemris.opp.servlets.forms.AddChildForm;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/success")
public class IndexSuccess extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setAttribute("confirmation", true);
		
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
}
