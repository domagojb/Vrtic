package hr.fer.zemris.opp.servlets.forms;

import hr.fer.zemris.opp.dao.DAOProvider;
import hr.fer.zemris.opp.model.Group;
import hr.fer.zemris.opp.model.Workplace;
import hr.fer.zemris.opp.model.users.User;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

/**
 * JavaBeans form representation of the class {@link Group}.
 * 
 * @author domagoj
 *
 */
public class AddGroupForm {
	
	/**
	 * Lower age boundary.
	 */
	private String low;
	
	/**
	 * Upper age boundary.
	 */
	private String high;
	
	/**
	 * Capacity of the group.
	 */
	private String capacity;
	
	/**
	 * Educators added to the group.
	 */
	private String[] educators;
	
	/**
	 * Workplace the group belongs too.
	 */
	private String workplace;
	
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
		this.capacity = req.getParameter("capacity");
		this.low = req.getParameter("low");
		this.high = req.getParameter("high");
		this.educators = req.getParameterValues("educators");
		this.workplace = req.getParameter("workplace");
	}
	
	/**
	 * Make sure to call {@link #validate()} before to check for errors.
	 * The method will calculate the password hash for the given password.
	 * 
	 * @return a {@link Group} generated from the form
	 */
	public Group getGroupFromForm() {
		Group g = new Group();
		
		g.setCapacity(Integer.valueOf(this.capacity));
		g.setLow(Byte.valueOf(this.low));
		g.setHigh(Byte.valueOf(this.high));
		
		int workplaceId = Integer.valueOf(this.workplace);
		Workplace w = DAOProvider.getDAO().getWorkplace(workplaceId);
		g.setWorkplace(w);
		
		List<User> educatorsList = new ArrayList<User>();
		
		for(String uId : this.educators) {
			educatorsList.add(DAOProvider.getDAO().getUser(Long.valueOf(uId)));
		}
		
		g.setEducators(educatorsList);
		
		return g;
	}
	
	/**
	 * Checks the form. If there are any error it will map them.
	 * Check {@link #hasErrors()} and {@link #hasError(String)} for
	 * errors after calling this method.
	 */
	public void validate() {
		errors.clear();
	
		try {
			int iCapacity = Integer.valueOf(capacity);
			if (iCapacity < 1) {
				errors.put("capacity", "Kapacitet mora biti veći od 0");
			}
		} catch (NumberFormatException e) {
			errors.put("capacity", "Kriva vrijednost");
		}
		
		int iLow = -1;
		try {
			iLow = Integer.valueOf(low);
			if (iLow < 0) {
				errors.put("low", "Dobna granica mora biti pozitivna");
			}
		} catch (NumberFormatException e) {
			errors.put("low", "Kriva vrijednost");
		}
		
		int iHigh = 0;
		try {
			iHigh = Integer.valueOf(high);
			if (iHigh < 0) {
				errors.put("high", "Dobna granica mora biti pozitivna");
			}
		} catch (NumberFormatException e) {
			errors.put("high", "Kriva vrijednost");
		}
		
		if (iLow > iHigh) {
			errors.put("high", "Gornja granica mora biti veća ili jednaka donjoj");
		}
		
		if (educators == null || educators.length < 2) {
			errors.put("educators", "Minimalno 2 odgajatelja moraju biti odabrana");
		}
		
		if (workplace == null) {
			errors.put("workplace", "Vrtić mora biti odabran");
		}
	}

	/**
	 * @return the low
	 */
	public String getLow() {
		return low;
	}

	/**
	 * @param low the low to set
	 */
	public void setLow(String low) {
		this.low = low;
	}

	/**
	 * @return the high
	 */
	public String getHigh() {
		return high;
	}

	/**
	 * @param high the high to set
	 */
	public void setHigh(String high) {
		this.high = high;
	}

	/**
	 * @return the capacity
	 */
	public String getCapacity() {
		return capacity;
	}

	/**
	 * @param capacity the capacity to set
	 */
	public void setCapacity(String capacity) {
		this.capacity = capacity;
	}

	/**
	 * @return the educators
	 */
	public String[] getEducators() {
		return educators;
	}

	/**
	 * @param educators the educators to set
	 */
	public void setEducators(String[] educators) {
		this.educators = educators;
	}

	/**
	 * @return the workplace
	 */
	public String getWorkplace() {
		return workplace;
	}

	/**
	 * @param workplace the workplace to set
	 */
	public void setWorkplace(String workplace) {
		this.workplace = workplace;
	}

	
}
