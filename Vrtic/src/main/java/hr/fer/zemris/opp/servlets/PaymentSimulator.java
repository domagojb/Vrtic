package hr.fer.zemris.opp.servlets;

import hr.fer.zemris.opp.dao.DAOProvider;
import hr.fer.zemris.opp.model.Child;
import hr.fer.zemris.opp.model.Group;
import hr.fer.zemris.opp.model.records.PaymentRecord;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/paymentsimulator")
public class PaymentSimulator extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		String sGID = req.getParameter("group");
		
		List<Group> groups = DAOProvider.getDAO().getAllGroups();
		req.setAttribute("groups", groups);
		
		// a group has not been chosen
		if (sGID == null) {
			req.getRequestDispatcher("/WEB-INF/pages/paymentsimulator.jsp").forward(req, resp);
			return;
		}
		
		long gid;
		try {
			gid = Long.valueOf(sGID);
		} catch (NumberFormatException e) {
			req.setAttribute("userErrorMessage", "Greska: Ne mogu konvertirati primljeni group id u tip long");
			req.getRequestDispatcher("/WEB-INF/pages/Error.jsp").forward(req, resp);
			return;
		}
		
		List<Child> children = DAOProvider.getDAO().getChildrenInGroup(gid);
		req.setAttribute("children", children);
		req.getRequestDispatcher("/WEB-INF/pages/paymentsimulator.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String sCID = req.getParameter("child");
		long cid;
		try {
			cid = Long.valueOf(sCID);
		} catch (NumberFormatException e) {
			List<Group> groups = DAOProvider.getDAO().getAllGroups();
			req.setAttribute("groups", groups);
			req.setAttribute("error", "Nije odabrano dijete");
			req.getRequestDispatcher("/WEB-INF/pages/paymentsimulator.jsp").forward(req, resp);
			return;
		}
		
		int month;
		int year;
		
		String sYear = req.getParameter("year");
		String sMonth = req.getParameter("month");
		
		if (sYear == null || sYear.isEmpty()) {
			List<Group> groups = DAOProvider.getDAO().getAllGroups();
			req.setAttribute("groups", groups);
			req.setAttribute("error", "Godina nije upisana");
			req.getRequestDispatcher("/WEB-INF/pages/paymentsimulator.jsp").forward(req, resp);
			return;
		}
		
		if (sMonth == null || sMonth.isEmpty()) {
			List<Group> groups = DAOProvider.getDAO().getAllGroups();
			req.setAttribute("groups", groups);
			req.setAttribute("error", "Mjesec nije upisan");
			req.getRequestDispatcher("/WEB-INF/pages/paymentsimulator.jsp").forward(req, resp);
			return;
		}
		
		try {
			month = Integer.valueOf(sMonth);
		} catch (NumberFormatException e) {
			req.setAttribute("userErrorMessage", "Greska: Ne mogu konvertirati primljeni month u tip int");
			req.getRequestDispatcher("/WEB-INF/pages/Error.jsp").forward(req, resp);
			return;
		}
		
		try {
			year = Integer.valueOf(sYear);
		} catch (NumberFormatException e) {
			req.setAttribute("userErrorMessage", "Greska: Ne mogu konvertirati primljeni year u tip int");
			req.getRequestDispatcher("/WEB-INF/pages/Error.jsp").forward(req, resp);
			return;
		}
		
		PaymentRecord record = new PaymentRecord();
		
		Child c = DAOProvider.getDAO().getChild(cid);
		
		record.setChild(c);
		
		try {
			record.setMonth(month);
		} catch (IllegalArgumentException e) {
			List<Group> groups = DAOProvider.getDAO().getAllGroups();
			req.setAttribute("groups", groups);
			req.setAttribute("error", "Ne valjani mjesec: Interval od 1 do 12");
			req.getRequestDispatcher("/WEB-INF/pages/paymentsimulator.jsp").forward(req, resp);
			return;
		}
		
		record.setYear(year);
		c.addPaymentRecord(record);
		
		DAOProvider.getDAO().insertPaymentRecord(record);
		resp.sendRedirect(req.getServletContext().getContextPath());
	}
}
