package hr.fer.zemris.opp.servlets.userfunctions;

import hr.fer.zemris.opp.dao.DAOProvider;
import hr.fer.zemris.opp.model.records.EducatorActivity;
import hr.fer.zemris.opp.model.users.User;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/userpanel/eduworktime")
public class CalculateEducatorWorktime extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		boolean auth = checkAuthorization(req, resp);
		
		if (!auth) {
			return;
		}
		
		List<User> users = DAOProvider.getDAO().getAllUsers();
		List<User> educators = new ArrayList<User>();
		
		for(User u : users) {
			if (u.getType().equals("edu")) {
				educators.add(u);
			}
		}
		
		req.setAttribute("educators", educators);
		
		String sUID = req.getParameter("educator");
		String sMonth = req.getParameter("month");
		String sYear = req.getParameter("year");
		
		if (sUID != null) {
			long uid;
			long month;
			long year;
			
			try {
				uid = Long.valueOf(sUID);
				month = Long.valueOf(sMonth);
				year = Long.valueOf(sYear);
			} catch (NumberFormatException e) {
				req.setAttribute("userErrorMessage", "interna pogreška -733");
				req.getRequestDispatcher("/WEB-INF/pages/Error.jsp").forward(req, resp);
				return;
			}
			
			req.setAttribute("year", year);
			
			setMonthString(req, month);
			
			int eW = 0;
			int pW = 0;
			int wP = 0;
			int s = 0;
			
			User u = DAOProvider.getDAO().getUser(uid);
			req.setAttribute("educator", u);
			List<EducatorActivity> logs = u.getActivityLog();
			
			for (EducatorActivity educatorActivity : logs) {
				Calendar cal = Calendar.getInstance();
			    cal.setTime(educatorActivity.getDate());
			    int logYear = cal.get(Calendar.YEAR);
			    int logMonth = cal.get(Calendar.MONTH) + 1;
			    if (logYear != year || logMonth != month) {
			    	continue;
			    }
			    
			    eW += educatorActivity.getWorkHour_eW();
			    pW += educatorActivity.getWorkHour_pW();
			    s += educatorActivity.getWorkHour_s();
			    wP += educatorActivity.getWorkHour_wP();
			  
			}
			
			calculateWorkHours(req, eW, pW, wP, s);
		}
		
		req.getRequestDispatcher("/WEB-INF/pages/eduworktime.jsp").forward(req, resp);
	}

	private void calculateWorkHours(HttpServletRequest req, int eW, int pW,
			int wP, int s) {
		String eW_b = "Zadovoljeno";
		String wP_b = "Zadovoljeno";
		String s_b = "Zadovoljeno";
		String pW_b = "Zadovoljeno";
		
		if (eW < 500) {
			eW_b = "Nije zadovoljeno";
		}
		
		if (wP < 500) {
			wP_b = "Nije zadovoljeno";
		}
		if (s < 500) {
			s_b = "Nije zadovoljeno";
		}
		
		if (pW < 500) {
			pW_b = "Nije zadovoljeno";
		}
		
		req.setAttribute("eW", eW);
		req.setAttribute("eW_b", eW_b);
		req.setAttribute("wP", wP);
		req.setAttribute("wP_b", wP_b);
		req.setAttribute("s", s);
		req.setAttribute("s_b", s_b);
		req.setAttribute("pW", pW);
		req.setAttribute("pW_b", pW_b);
		
	}

	private void setMonthString(HttpServletRequest req, long month) {
		String monthCro = "";
		if (month == 1) {
			monthCro = "Siječanj";
		} else if (month == 2) {
			monthCro = "Veljača";
		} else if (month == 3) {
			monthCro = "Ožujak";
		} else if (month == 4) {
			monthCro = "Travanj";
		} else if (month == 5) {
			monthCro = "Svibanj";
		} else if (month == 6) {
			monthCro = "Lipanj";
		} else if (month == 7) {
			monthCro = "Srpanj";
		} else if (month == 8) {
			monthCro = "Kolovoz";
		} else if (month == 9) {
			monthCro = "Rujan";
		} else if (month == 10) {
			monthCro = "Listopad";
		} else if (month == 11) {
			monthCro = "Studeni";
		} else if (month == 12) {
			monthCro = "Prosinac";
		} 
		
		req.setAttribute("month", monthCro);
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
