package hr.fer.zemris.opp.servlets.userfunctions;

import hr.fer.zemris.opp.dao.DAOProvider;
import hr.fer.zemris.opp.model.Group;
import hr.fer.zemris.opp.model.Parent;
import hr.fer.zemris.opp.model.Workplace;
import hr.fer.zemris.opp.model.users.User;
import hr.fer.zemris.opp.servlets.forms.AddChildByAdminForm;

import java.io.IOException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet for entering a child into a group.
 * 
 * @author domagoj
 *
 */
@WebServlet("/userpanel/addchild")
public class AddChild extends HttpServlet {

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
		
		List<Parent> parents = DAOProvider.getDAO().getAllParents();
		List<Group> groups = DAOProvider.getDAO().getAllGroups();
		
		req.setAttribute("parents", parents);
		req.setAttribute("groups", groups);
		req.setAttribute("form", new AddChildByAdminForm());
		
		req.getRequestDispatcher("/WEB-INF/pages/addchild.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		AddChildByAdminForm form = new AddChildByAdminForm();
		form.fillFromHttpRequest(req);
		
		form.validate();
		
		
		if(form.hasErrors()) {
			req.setAttribute("form", form);
			
			List<Parent> parents = DAOProvider.getDAO().getAllParents();
			List<Group> groups = DAOProvider.getDAO().getAllGroups();
			
			req.setAttribute("parents", parents);
			req.setAttribute("groups", groups);
			
			req.getRequestDispatcher("/WEB-INF/pages/addchild.jsp").forward(req, resp);
			return;
		}
		
		req.setAttribute("userErrorMessage", form.getBday());
		req.getRequestDispatcher("/WEB-INF/pages/Error.jsp").forward(req, resp);
	}
}
