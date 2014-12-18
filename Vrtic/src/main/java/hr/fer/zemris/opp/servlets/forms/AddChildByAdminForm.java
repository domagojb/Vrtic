package hr.fer.zemris.opp.servlets.forms;

import hr.fer.zemris.opp.dao.DAOProvider;
import hr.fer.zemris.opp.model.Child;
import hr.fer.zemris.opp.model.Group;
import hr.fer.zemris.opp.model.Parent;
import hr.fer.zemris.opp.model.Workplace;
import hr.fer.zemris.opp.model.users.User;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.joda.time.DateTime;
import org.joda.time.Period;


/**
 * Form that the administrator uses to add and verify a child and parent.
 * 
 * @author domagoj
 *
 */
public class AddChildByAdminForm {
	
	/**
	 * Group id of the group the child wants to join.
	 */
	private long groupId = -1;
	
	/**
	 * The id of the parent if the parent is an existing one.
	 */
	private long parentId = -1;
	
	/**
	 * Parent's first name.
	 */
	private String pFirstName = "";
	
	/**
	 * Parent's last name.
	 */
	private String pLastName = "";
	
	/**
	 * Parent's OIB.
	 */
	private String pOIB = "";

	/**
	 * Parent's (and childs) address.
	 */
	private String address = "";
	
	/**
	 * Parent's phone/contact number.
	 */
	private String phone = "";
	
	/**
	 * Parent's social status.
	 */
	private String socialStatus = "";
	
	/**
	 * Parents income.
	 */
	private String income = "";
	
	/**
	 * Child's first name.
	 */
	private String cFirstName = "";
	
	/**
	 * Child's last name.
	 */
	private String cLastName = "";
	
	/**
	 * Child's OIB.
	 */
	private String cOIB = "";
	
	/**
	 * Child's sex.
	 */
	private String sex = "";
	
	/**
	 * Child's birtday date.
	 */
	private String bday = "";
	
	// Mapa<property, error message>
	/**
	 * Map of potential errors.
	 */
	Map<String, String> errors = new HashMap();

	/**
	 * @return the groupId
	 */
	public long getGroupId() {
		return groupId;
	}

	/**
	 * @param groupId the groupId to set
	 */
	public void setGroupId(long groupId) {
		this.groupId = groupId;
	}

	/**
	 * @return the parentId
	 */
	public long getParentId() {
		return parentId;
	}

	/**
	 * @param parentId the parentId to set
	 */
	public void setParentId(long parentId) {
		this.parentId = parentId;
	}

	/**
	 * @return the pFirstName
	 */
	public String getpFirstName() {
		return pFirstName;
	}

	/**
	 * @param pFirstName the pFirstName to set
	 */
	public void setpFirstName(String pFirstName) {
		this.pFirstName = pFirstName;
	}

	/**
	 * @return the pLastName
	 */
	public String getpLastName() {
		return pLastName;
	}

	/**
	 * @param pLastName the pLastName to set
	 */
	public void setpLastName(String pLastName) {
		this.pLastName = pLastName;
	}

	/**
	 * @return the pOIB
	 */
	public String getpOIB() {
		return pOIB;
	}

	/**
	 * @param pOIB the pOIB to set
	 */
	public void setpOIB(String pOIB) {
		this.pOIB = pOIB;
	}

	/**
	 * @return the address
	 */
	public String getAddress() {
		return address;
	}

	/**
	 * @param address the address to set
	 */
	public void setAddress(String address) {
		this.address = address;
	}

	/**
	 * @return the phone
	 */
	public String getPhone() {
		return phone;
	}

	/**
	 * @param phone the phone to set
	 */
	public void setPhone(String phone) {
		this.phone = phone;
	}

	/**
	 * @return the socialStatus
	 */
	public String getSocialStatus() {
		return socialStatus;
	}

	/**
	 * @param socialStatus the socialStatus to set
	 */
	public void setSocialStatus(String socialStatus) {
		this.socialStatus = socialStatus;
	}

	/**
	 * @return the income
	 */
	public String getIncome() {
		return income;
	}

	/**
	 * @param income the income to set
	 */
	public void setIncome(String income) {
		this.income = income;
	}

	/**
	 * @return the cFirstName
	 */
	public String getcFirstName() {
		return cFirstName;
	}

	/**
	 * @param cFirstName the cFirstName to set
	 */
	public void setcFirstName(String cFirstName) {
		this.cFirstName = cFirstName;
	}

	/**
	 * @return the cLastName
	 */
	public String getcLastName() {
		return cLastName;
	}

	/**
	 * @param cLastName the cLastName to set
	 */
	public void setcLastName(String cLastName) {
		this.cLastName = cLastName;
	}

	/**
	 * @return the cOIB
	 */
	public String getcOIB() {
		return cOIB;
	}

	/**
	 * @param cOIB the cOIB to set
	 */
	public void setcOIB(String cOIB) {
		this.cOIB = cOIB;
	}

	/**
	 * @return the sex
	 */
	public String getSex() {
		return sex;
	}

	/**
	 * @param sex the sex to set
	 */
	public void setSex(String sex) {
		this.sex = sex;
	}

	/**
	 * @return the bday
	 */
	public String getBday() {
		return bday;
	}

	/**
	 * @param bday the bday to set
	 */
	public void setBday(String bday) {
		this.bday = bday;
	}
	
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
		String sGID = req.getParameter("group");
		
		if (sGID != null) {
			this.groupId = Long.valueOf(sGID);
		}
		
		String sPID = req.getParameter("parent");
		
		if (sPID != null) {
			this.parentId = Long.valueOf(sPID);
		}
		
		this.pFirstName = req.getParameter("firstname");
		this.pLastName = req.getParameter("lastname");
		this.pOIB = req.getParameter("oib");
		this.address = req.getParameter("address");
		this.phone = req.getParameter("phone");
		this.socialStatus = req.getParameter("socialstatus");
		this.income = req.getParameter("income");
		this.cFirstName = req.getParameter("c_firstname");
		this.cLastName = req.getParameter("c_lastname");
		this.cOIB = req.getParameter("c_oib");
		this.sex = req.getParameter("sex");
		this.bday = req.getParameter("birthdate");
	}
	
	/**
	 * Make sure to call {@link #validate()} before to check for errors.
	 * 
	 * @return a {@link Child} generated from the form
	 */
	public Child getChildFromForm() {
		return null;
	}
	
	/**
	 * Returns the parent of the given child.
	 * 
	 * The parent returned by this method can be an already existing
	 * parent since he can have multiple children.
	 * 
	 * Use {@link #isExistingParent()} to check wether you need to save
	 * the parent or not.
	 * 
	 * Make sure to call {@link #validate()} before to check for errors.
	 * 
	 * @return a {@link Parent} generated from form.
	 */
	public Parent getParentFromForm() {
		return null;
	}
	
	public boolean isExistingParent() {
		if (parentId < 0) {
			return false;
		}
		
		return true;
	}
	
	/**
	 * Checks the form. If there are any error it will map them.
	 * Check {@link #hasErrors()} and {@link #hasError(String)} for
	 * errors after calling this method.
	 * @throws ParseException on error parsin birth date
	 */
	public void validate() {
		errors.clear();
	
		if (groupId == -1) {
			errors.put("group", "Grupa nije odabrana");
		} else {
			// Is the kid of the right age? Huh?
			Date bdaydate = null;
			boolean skip = false;
			try {
				bdaydate = new SimpleDateFormat("yyyy-MM-dd").parse(bday);
			} catch (ParseException e) {
				errors.put("bday", "Datum je obavezan");
				skip = true;
			}
			
			Group g = DAOProvider.getDAO().getGroup(groupId);
			
			if (!skip) {
				Date currdate = new Date();
				Period p = new Period(new DateTime(bdaydate), new DateTime(currdate));
				
				int year = p.getYears();
				if (year < g.getLow()) {
					errors.put("bday", "Nedovoljna starost");
				}
				
				if (year > g.getHigh()) {
					errors.put("bday", "Pre staro dijete");
				}
			}
			
			// Is there room in the group????
			if (g.hasRoom() == false) {
				errors.put("group", "Grupa je puna");
			}
		}
		
		// an existing parent wasn't selected, expecting parent info
		if (parentId == -1) {
			if (this.pFirstName.isEmpty() || this.pFirstName.matches(".*\\d.*")) {
				errors.put("firstname", "Krivi unos");
			}
			
			if (this.pLastName.isEmpty() || this.pLastName.matches(".*\\d.*")) {
				errors.put("lastname", "Krivi unos");
			}
			
			// OIB contains 11 digits
			final int OIBLEN = 11;
			if (this.pOIB.isEmpty() || this.pOIB.length() != OIBLEN || this.pOIB.matches(".*\\D.*")) {
				errors.put("oib", "Krivi unos");
			}
			
			if (this.address.isEmpty()) {
				errors.put("address", "Adresa je obavezna");
			}
			
			if (this.phone.isEmpty()) {
				errors.put("phone", "Broj je obavezan");
			}
			
			if (this.socialStatus != null && this.income.isEmpty()) {
				errors.put("income", "Primanja su obavezna ako se potražuje pravo temeljem s.s.");
			}
		}
		
		if (this.cFirstName.isEmpty() || this.cFirstName.matches(".*\\d.*")) {
			errors.put("c_firstname", "Krivi unos");
		}
		
		if (this.cLastName.isEmpty() || this.cLastName.matches(".*\\d.*")) {
			errors.put("c_lastname", "Krivi unos");
		}
		
		// OIB contains 11 digits
		final int OIBLEN = 11;
		if (this.cOIB.isEmpty() || this.cOIB.length() != OIBLEN || this.cOIB.matches(".*\\D.*")) {
			errors.put("c_oib", "Krivi unos");
		}
	
	}
}
