package hr.fer.zemris.opp.servlets.forms;

import hr.fer.zemris.opp.model.Workplace;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

/**
 * JavaBean form for {@link Workplace}.
 * 
 * @author domagoj
 *
 */
public class AddWorkplaceForm {

	/**
	 * Address of the workplace.
	 */
	private String address = "";
	
	/**
	 * Town in which the workplace is stationed in.
	 */
	private String town = "";
	
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
		this.address = req.getParameter("address");
		this.town = req.getParameter("town");
	}
	
	/**
	 * Make sure to call {@link #validate()} before to check for errors.
	 * The method will calculate the password hash for the given password.
	 * 
	 * @return a {@link Workplace} generated from the form
	 */
	public Workplace getWorkplaceFromForm() {
		Workplace w = new Workplace();
		
		w.setAddress(address);
		w.setTown(town);
		
		return w;
	}
	
	/**
	 * Checks the form. If there are any error it will map them.
	 * Check {@link #hasErrors()} and {@link #hasError(String)} for
	 * errors after calling this method.
	 */
	public void validate() {
		errors.clear();
	
		if(address.isEmpty()) {
			errors.put("address", "Polje je obavezno.");
		}
		
		if(town.isEmpty()) {
			errors.put("town", "Polje je obavezno");
		}
	
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
	 * @return the town
	 */
	public String getTown() {
		return town;
	}

	/**
	 * @param town the town to set
	 */
	public void setTown(String town) {
		this.town = town;
	}
		
}
