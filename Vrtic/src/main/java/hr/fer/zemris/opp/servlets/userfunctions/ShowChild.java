package hr.fer.zemris.opp.servlets.userfunctions;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import hr.fer.zemris.opp.dao.DAOProvider;
import hr.fer.zemris.opp.model.Child;
import hr.fer.zemris.opp.model.records.ChildRecord;
import hr.fer.zemris.opp.model.records.PaymentRecord;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet expects {@link Child#getId()} mapped to parameter "id".
 * The child is then mapped as the argument "child".
 * 
 * @author domagoj
 *
 */
@WebServlet("/userpanel/showchild")
public class ShowChild extends HttpServlet {

	/**
	 * Servlet expects {@link Child#getId()} mapped to parameter "id".
	 * The child is then mapped as the argument "child".
	 */
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		boolean auth = checkAuthorization(req, resp);
		
		if (!auth) {
			return;
		}
		
		String sCID = req.getParameter("id");
		if (sCID == null) {
			req.setAttribute("userErrorMessage", "Interna pogreška -893");
			req.getRequestDispatcher("/WEB-INF/pages/Error.jsp").forward(req, resp);
			return;
		}
		
		long cid;
		try {
			cid = Long.valueOf(sCID);
		} catch (NumberFormatException e) {
			req.setAttribute("userErrorMessage", "Interna pogreška -894");
			req.getRequestDispatcher("/WEB-INF/pages/Error.jsp").forward(req, resp);
			return;
		}
		
		Child c = DAOProvider.getDAO().getChild(cid);
		req.setAttribute("child", c);
		
		// the years that can be selected for showing payment and attendance records
		final int maxYear = Calendar.getInstance().get(Calendar.YEAR);
		final int minYear = 1990;

		List<Integer> years = new ArrayList<Integer>();
		for (int i = maxYear; i >= minYear; i--) {
			years.add(i);
		}
		
		req.setAttribute("years", years);
		
		String selectedPaymentYear = req.getParameter("paymentyear");
		int paymentYear = maxYear;
		if (selectedPaymentYear != null) {
			paymentYear = Integer.valueOf(selectedPaymentYear);
		}
		req.setAttribute("selectedPaymentYear", paymentYear);
		
		paymentInfo(req, c, paymentYear);
		
		attendanceInfo(req, c, paymentYear);
		
		req.getRequestDispatcher("/WEB-INF/pages/showchild.jsp").forward(req, resp);
	}

	/**
	 * Sets the needed attendance numbers for each month for the given year.
	 * 
	 * @param c
	 * @param paymentYear for which to calculate attendances for each month
	 */
	private void attendanceInfo(HttpServletRequest req, Child c, int paymentYear) {
		List<ChildRecord> attendaceRecords = c.getRecords();
		List<Integer> attendaceNumberPerMonth = new ArrayList<Integer>();
		for(int i = 0; i < 12; i++) {
			attendaceNumberPerMonth.add(0);
		}
		for (ChildRecord record : attendaceRecords) {
			Calendar cal = Calendar.getInstance();
		    cal.setTime(record.getDate());
		    int year = cal.get(Calendar.YEAR);
		    if (year != paymentYear) {
		    	continue;
		    }
		    
		    int month = cal.get(Calendar.MONTH);
		    int currNum = attendaceNumberPerMonth.get(month); // months start with 0
		    attendaceNumberPerMonth.set(month, currNum+1);
		}
		req.setAttribute("attendanceCount", attendaceNumberPerMonth);
	}

	/**
	 * Sets all the payment info for the selected year or current year if no year has 
	 * been selected.
	 * 
	 * @param req
	 * @param c
	 */
	private void paymentInfo(HttpServletRequest req, Child c, final int paymentYear) {
		List<PaymentRecord> paymentRecords = c.getPaymentRecords();
		List<String> paymentStrings = new ArrayList<String>();
		// set the initial payment strings for each month to "not payed"
		for(int i = 0; i < 12; i++) {
			paymentStrings.add("Ne");
		}
		// set the payed months to "payed"S
		for (PaymentRecord paymentRecord : paymentRecords) {
			if (paymentRecord.getYear() != paymentYear) {
				continue;
			}
			paymentStrings.set(paymentRecord.getMonth() - 1, "Da");
		}
		req.setAttribute("paymentStrings", paymentStrings);
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
