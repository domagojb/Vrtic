package hr.fer.zemris.opp.servlets.forms;

import hr.fer.zemris.opp.dao.DAO;
import hr.fer.zemris.opp.dao.DAOProvider;
import hr.fer.zemris.opp.model.Group;
import hr.fer.zemris.opp.model.Workplace;
import hr.fer.zemris.opp.model.records.EducatorActivity;
import hr.fer.zemris.opp.model.users.FormException;
import hr.fer.zemris.opp.model.users.User;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import net.sf.ehcache.search.attribute.JavaBeanAttributeExtractor;

/**
 * Form representation of the {@link EducatorActivity}.
 * 
 * @author domagoj
 *
 */
public class EnterEducatorActivityForm {

	private String userid;
	private Date date;
	private String sDate;
	private String workHour_eW;
	private String workHour_wP;
	private String workHour_s;
	private String workHour_pW;
	
	private int ew;
	private int wp;
	private int s;
	private int pw;
	
	private String effectiveWork = "";
	private String workPreparation = "";
	private String specialization = "";
	private String parentWork = "";
	
	// Mapa<property, error message>
	/**
	 * Map of potential errors.
	 */
	Map<String, String> errors = new HashMap();
	
	/**
	 * Returns the error message mapped to <code>name</code>, or
	 * <code>null</code> if there is no error.
	 * 
	 * @param name name of the error
	 * @return the error message mapped to <code>name</code>, or <code>null</code> if there is no error.
	 */
	public String getError(String name) {
		return errors.get(name);
	}
	
	/**
	 * @return <code>true</code> if the form has errors, else <code>false</code>
	 */
	public boolean hasErrors() {
		return !errors.isEmpty();
	}
	
	/**
	 * Checks if error with given name exists.
	 * 
	 * @param name of the error to check
	 * @return <code>true</code> if an error exists, <code>false</code> else.
	 */
	public boolean hasError(String name) {
		return errors.containsKey(name);
	}
	
	/**
	 * Fills up the form from the request.
	 */
	public void fillFromHttpRequest(HttpServletRequest req) {
		this.userid = req.getParameter("uid");
		this.sDate = req.getParameter("date");
		this.effectiveWork = req.getParameter("ew");
		this.parentWork = req.getParameter("pw");
		this.specialization = req.getParameter("spec");
		this.workPreparation = req.getParameter("wp");
		this.workHour_eW = req.getParameter("ew_h");
		this.workHour_pW = req.getParameter("pw_h");
		this.workHour_s = req.getParameter("spec_h");
		this.workHour_wP = req.getParameter("wp_h");
	}
	
	/**
	 * Make sure to call {@link #validate()} before to check for errors.
	 * 
	 * @return a {@link EducatorActivity} generated from the form
	 */
	public EducatorActivity getActivityFromForm() {
		EducatorActivity log = new EducatorActivity();
		log.setDate(date);
		Long id = Long.valueOf(userid);
		User u = DAOProvider.getDAO().getUser(id);
		log.setEducator(u);
		log.setEffectiveWork(effectiveWork);
		log.setParentWork(parentWork);
		log.setSpecialization(specialization);
		log.setWorkPreparation(workPreparation);
		log.setWorkHour_eW(ew);
		log.setWorkHour_pW(pw);
		log.setWorkHour_wP(wp);
		log.setWorkHour_s(s);
		
		return log;
	}
	
	/**
	 * Checks the form. If there are any error it will map them.
	 * Check {@link #hasErrors()} and {@link #hasError(String)} for
	 * errors after calling this method.
	 */
	public void validate() {
		errors.clear();
	
		try {
			this.date = new SimpleDateFormat("yyyy-MM-dd").parse(sDate);
		} catch (ParseException e1) {
			errors.put("date", "Neispravan datum");
		}
		
		try {
			this.ew = Integer.valueOf(workHour_eW);
			this.wp = Integer.valueOf(workHour_wP);
			this.s = Integer.valueOf(workHour_s);
			this.pw = Integer.valueOf(workHour_pW);
		} catch (NumberFormatException e) {
			throw new FormException("Interna pogreska -634");
		}
	}
}
