package hr.fer.zemris.opp.servlets.userfunctions;

import hr.fer.zemris.opp.dao.DAOProvider;
import hr.fer.zemris.opp.model.SignUpAlgorithm;
import hr.fer.zemris.opp.model.records.SignUpRecord;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/userpanel/closesignup")
public class CloseSignUp extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		boolean auth = checkAuthorization(req, resp);
		
		if (!auth) {
			return;
		}
		
		List<SignUpRecord> records = DAOProvider.getDAO().getSignUpRecords();
		if (records == null) {
			req.setAttribute("msg", "Prijave nisu u tijeku");
			req.getRequestDispatcher("/WEB-INF/pages/closesignup.jsp").forward(req, resp);
			return;
		} else {
			if (records.size() == 0) {
				req.setAttribute("msg", "Prijave nisu u tijeku");
				req.getRequestDispatcher("/WEB-INF/pages/closesignup.jsp").forward(req, resp);
				return;
			}
			
			final int FIRST_ELEMENT = 0;
			SignUpRecord record = records.get(FIRST_ELEMENT);
			
			if (record.isSignUpOpen() == false) {
				req.setAttribute("msg", "Prijave nisu u tijeku");
				req.getRequestDispatcher("/WEB-INF/pages/closesignup.jsp").forward(req, resp);
				return;
			}
			
			record.setSignUpOpen(false);
			req.setAttribute("msg", "Prijave su zatvorene. Pokrećem upis.");
			req.getRequestDispatcher("/WEB-INF/pages/closesignup.jsp").forward(req, resp);
			
			Thread signUpThread = new Thread(new SignUpAlgorithm());
			signUpThread.start();
			
			return;
		}
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
